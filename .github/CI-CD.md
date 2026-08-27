# 🤖 Chaîne CI/CD — Ontologie Réseau V0

Workflows GitHub Actions automatisant la création de branches, commits, PRs et validations pour le projet d'ontologie réseau.

---

## 📋 Workflows disponibles

### 1. `ci-ontologie.yml` — Principal

**Déclencheurs** :
- 🔄 **Auto** : chaque push sur `main` touchant `ontology/`, `data/`, `docs/modele.md`
- 🚀 **Manuel** : via `workflow_dispatch` (onglet "Actions" GitHub)

**Étapes** :

#### A. Validation (systématique)
```
✓ Syntaxe Turtle
✓ Décompte concepts (≤ 50)
✓ Validation données (si présentes)
```

#### B. Création de branche + PR (sur demande manuelle)
```
✓ Créer branche nommée
✓ Stager changements
✓ Créer commit formaté (conventional commits)
✓ Pousser branche
✓ Créer PR avec description structurée
```

**Paramètres (en mode manuel)** :
- `phase` : phase du travail (2-conceptualisation, 3-formalisation, 4-peuplement, 5-evaluation)
- `branch_name` : nom de la branche (ex: `conceptualisation`, `OWL`, `peuplement`)

**Exemple d'utilisation** :
```
GitHub Actions > ci-ontologie > Run workflow
  phase: 3-formalisation
  branch_name: OWL
→ Lance validation, crée branche OWL, commit, PR
```

---

### 2. `validate-sparql-shacl.yml` — Requêtes et contraintes

**Déclencheurs** :
- 🔄 Push ou PR touchant `queries/`, `shapes/`, `data/`
- 🚀 Manuel

**Étapes** :
```
✓ Vérifier syntaxe SPARQL (SELECT/CONSTRUCT/ASK/DESCRIBE)
✓ Vérifier syntaxe SHACL (Turtle valide)
✓ Valider données contre contraintes SHACL (si pyshacl dispo)
```

Utile pour **phase 5 (évaluation)**.

---

## 🎯 Flux de travail complet

### Scénario : Ajouter une requête SPARQL (phase 5)

```
1. Créer requête localement : queries/CQ1.rq
2. Pousser sur branche ou main
   → ci-ontologie valide la syntaxe Turtle
   → validate-sparql-shacl vérifie la requête
3. Si tout OK → tous les checks passent ✅
4. Créer PR ou merger directement
```

### Scénario : Créer une nouvelle phase (ex: phase 4)

```
1. GitHub > Actions > ci-ontologie > Run workflow
2. Entrer :
   - phase: 4-peuplement
   - branch_name: peuplement
3. Le workflow :
   ✓ Valide ontologie existante
   ✓ Crée branche `peuplement`
   ✓ Crée commit avec message structuré
   ✓ Pousse branche
   ✓ Crée PR #X avec titre/description phase 4
4. Ouvrir PR, revoir, merger ou demander modifications
```

---

## 🔐 Authentification

**Tokens utilisés** :
- `GITHUB_TOKEN` (fourni automatiquement par GitHub Actions)
  - Scope : `repo` (lire/écrire le dépôt)
  - Valide uniquement pendant l'exécution
  - ✅ Sûr — pas d'exposition

**Pas besoin** de configurer `.env` ou secrets personnels pour les workflows.

---

## 📊 Vérifications automatisées

### Ontologie Turtle

```bash
# Syntaxe
python3 -c "import rdflib; g=rdflib.Graph(); g.parse('ontology/reseau-v0.ttl')"

# Décompte concepts
python3 - <<'PY'
import rdflib; from rdflib import RDF, OWL
g=rdflib.Graph(); g.parse("ontology/reseau-v0.ttl")
c=len(set(g.subjects(RDF.type,OWL.Class))); o=len(set(g.subjects(RDF.type,OWL.ObjectProperty)))
print(f"{c} classes + {o} ObjectProperties = {c+o}/50")
PY
```

### Requêtes SPARQL

```bash
# Syntaxe de base
grep -E "^(SELECT|CONSTRUCT|ASK|DESCRIBE)" queries/*.rq
```

### Contraintes SHACL

```bash
pip install pyshacl
# Valider avec pyshacl (cf. workflow)
```

---

## 🚀 Déploiement automatisé (optionnel)

Pour ajouter un workflow de **déploiement automatique** (ex: publier l'ontologie sur un serveur) :

```yaml
# .github/workflows/deploy-ontology.yml
name: Déployer ontologie

on:
  push:
    branches: [ main ]
    paths: [ 'ontology/reseau-v0.ttl' ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Pousser vers serveur
        run: |
          # Exemple : scp vers un serveur
          # ssh user@example.com "cd /ontologies && curl -O https://raw.githubusercontent.com/..."
          echo "✅ Déploiement (placeholder)"
```

---

## 📝 Messages de commit structurés

Les workflows utilisent **Conventional Commits** :

```
feat(phase-3): Formalisation OWL 2 Turtle

- 25 classes + 12 ObjectProperties + 12 DatatypeProperties
- Métadonnées DCMI Terms
- Alignements NML commentés
- Syntaxe validée, plafond respecté

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

**Format** :
```
<type>(<scope>): <subject>

<body>

<footer>
```

Types :
- `feat` — nouvelle fonctionnalité
- `fix` — correction de bug
- `docs` — documentation
- `refactor` — refacto sans changement logique
- `test` — ajout de tests

---

## ✅ Checklist avant d'utiliser

- [ ] `.github/workflows/ci-ontologie.yml` créé ✅
- [ ] `.github/workflows/validate-sparql-shacl.yml` créé ✅
- [ ] `GITHUB_TOKEN` disponible (auto) ✅
- [ ] Python 3.11+ sur les runners ✅
- [ ] `rdflib` installé dans les workflows ✅

---

## 🐛 Dépannage

### Workflow ne se déclenche pas

**Cause** : Les chemins (`paths`) ne correspondent pas.

**Solution** : Vérifier que les changements touchent bien `ontology/`, `data/`, ou `docs/modele.md`.

### Validation Turtle échoue

**Cause** : Syntaxe RDF/Turtle invalide.

**Solution** :
```bash
# Tester localement
python3 -c "import rdflib; rdflib.Graph().parse('ontology/reseau-v0.ttl', format='turtle')"
```

### PR ne se crée pas en mode manuel

**Cause** : Pas de changements detectés.

**Solution** : Vérifier que les fichiers ont changé. Si aucun changement, le workflow saute l'étape PR.

### SHACL validation échoue

**Cause** : Données non conformes aux contraintes.

**Solution** :
```bash
pip install pyshacl
pyshacl -d data/exemple-topologie.ttl -s shapes/*.ttl
```

---

## 📖 Ressources

- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [RDFlib Documentation](https://rdflib.readthedocs.io/)
- [PySHACL Documentation](https://github.com/RDFLib/pySHACL)

---

## 🎯 Prochaines améliorations

- [ ] Validation raisonneur HermiT (via Docker/Protégé headless)
- [ ] Linting SPARQL (vérifier les préfixes, les variables inutilisées)
- [ ] Rapport de couverture des CQ
- [ ] Déploiement automatique sur serveur
- [ ] Notifications Email en cas d'erreur
- [ ] Vérification des URIs externes (NML, DCMI Terms)

---

**Généré par** : Claude Code (2026-08-27)
