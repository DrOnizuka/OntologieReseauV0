---
name: git-push-secure
description: >
  Pousse vers le remote Git en toute sécurité, SANS lire ni manipuler de secret
  en clair (ne lit jamais GIT_PASSWORD ni le .env). L'authentification est
  déléguée à SSH ou à un credential helper de git. Le skill se limite à des
  vérifications pré-push et à un `git push` nu, avec rédaction de tout token
  éventuellement affiché. À utiliser quand l'utilisateur demande de pousser
  (« push », « pousse sur main », « synchronise avec l'équipe »).
---

# git-push-secure

Pousser vers le remote **sans que le skill ne voie le secret**. Le token/clé est
géré une fois pour toutes par git (credential helper) ou SSH ; ici on ne fait
que `git push`.

## Règles absolues

Objectif : **ne jamais EXPOSER le secret** (dans un log, une commande, un
argument, une URL ou un fichier). Le référencer uniquement de façon que git le
consomme lui-même.

1. **Ne jamais taper/afficher la valeur** de `GIT_PASSWORD` ni d'un token.
   On le référence seulement via `${GIT_PASSWORD}` (nom de variable) ou via le
   credential helper, dont git lit la sortie en interne.
2. **Ne jamais construire d'URL du type `https://user:token@github.com/...`**
   (le token finirait dans les logs / le reflog / `ps`).
3. Toujours faire passer la sortie du push dans la **rédaction `sed`** (ceinture
   de sécurité si git venait à afficher un token).
4. Si l'authentification échoue, **ne pas contourner** en mettant le token dans
   l'URL : diagnostiquer via la § Setup et s'arrêter.

## Procédure

### 1. Pré-vol (préflight)
```bash
git rev-parse --is-inside-work-tree            # doit répondre true
git status -sb                                 # branche + état
git log --oneline @{u}..HEAD 2>/dev/null || echo "pas d'upstream configuré"
```
- Résumer à l'utilisateur : **branche courante**, **commits à pousser**.
- Si l'arbre est sale (modifs non commitées), le signaler et demander quoi faire.
- Rappeler la convention `CONTRIBUTING.md` (branche + PR) si on pousse sur `main`.

### 2. Choisir le mécanisme d'authentification (aucun secret exposé)
```bash
git config --get remote.origin.url
git config --get credential.helper
```
Par ordre de préférence :
- **SSH** (`git@github.com:...`) → rien à faire, l'auth passe par SSH.
- **credential.helper** déjà configuré (`cache`, manager…) → git fournit le secret.
- **Sinon, mécanisme `.env` de ce dépôt** (défaut hors SSH) : utiliser le helper
  fourni, qui lit `.env` à l'exécution (voir § Mécanisme `.env`).

### 3. Pousser
Avec le helper `.env` (cas par défaut hors SSH) :
```bash
HELPER="$(git rev-parse --show-toplevel)/.claude/skills/git-push-secure/git-credential-env.sh"
git -c credential.helper="$HELPER" push "$@" 2>&1 \
  | sed -E 's/(ghp_|github_pat_)[A-Za-z0-9_]+/\1***REDACTED***/g'
```
Si un helper/SSH est déjà en place, un simple `git push "$@"` suffit (même
rédaction `sed`).

- La commande ne contient **aucune valeur de secret** : git invoque le helper,
  qui lit `.env` et écrit les identifiants sur sa sortie standard — **consommée
  par git, jamais affichée**.
- La rédaction `sed` couvre le cas résiduel d'un token dans un message d'erreur.

### 4. Rendre compte
- Confirmer la plage de refs poussée (`abc123..def456 main -> main`).
- En cas d'échec d'auth : renvoyer vers la § Setup, **sans** proposer de token
  dans l'URL.

## Mécanisme `.env` (défaut hors SSH)

Le dépôt fournit `.claude/skills/git-push-secure/git-credential-env.sh`, un
credential helper qui lit `GIT_USERNAME` / `GIT_PASSWORD` depuis le `.env` du
dépôt **au moment du push**. Prérequis :

- `.env` présent à la racine, contenant `GIT_USERNAME` et `GIT_PASSWORD`
  (un PAT GitHub) — `.env` est ignoré par git.
- Le script est exécutable (`chmod +x` déjà fait).

Le secret n'est jamais dans une commande, un argument, une URL ni un log : git
appelle le helper et consomme sa sortie en interne.

## Alternatives (setup par l'utilisateur)

- **SSH** (aucun token) — si disponible : `git remote set-url origin git@github.com:…`
  après avoir ajouté sa clé publique sur GitHub.
- **credential.helper cache** (HTTPS, token en mémoire, jamais sur disque) :
  `git config credential.helper 'cache --timeout=3600'` (saisie du PAT au 1er push).

Avec l'une de ces alternatives, le mécanisme `.env` n'est plus nécessaire.
