# 🚀 Guide d'utilisation — CI/CD Workflows

Voici comment utiliser les workflows GitHub Actions pour automatiser votre travail sur l'ontologie.

---

## ⚡ Démarrage rapide

### Option 1 : Via l'interface GitHub (recommandé)

```
1. Aller sur : https://github.com/DrOnizuka/OntologieReseauV0/actions
2. Cliquer sur "CI — Validation et déploiement ontologie"
3. Cliquer sur "Run workflow"
4. Remplir les paramètres :
   - phase: 3-formalisation (par ex.)
   - branch_name: OWL (par ex.)
5. Cliquer "Run workflow"
   ↓
   Le workflow :
   ✓ Valide l'ontologie
   ✓ Crée une branche
   ✓ Crée un commit formaté
   ✓ Pousse la branche
   ✓ Crée une PR
```

### Option 2 : Via un script local

```bash
.github/scripts/create-phase-branch.sh 3-formalisation OWL
```

---

## 📋 Workflows disponibles

### 1. **ci-ontologie.yml** — Validation + Création PR

| Aspect | Détail |
|--------|--------|
| **Déclenchement auto** | Push sur `main` touchant `ontology/`, `data/`, `docs/modele.md` |
| **Déclenchement manuel** | Via "Run workflow" (besoin paramètres) |
| **Validation** | ✓ Syntaxe Turtle ✓ Plafond (≤50) ✓ Données |
| **Création PR** | Branche + commit + push + PR (en manuel uniquement) |

**Paramètres** (mode manuel) :
```
phase : 2-conceptualisation | 3-formalisation | 4-peuplement | 5-evaluation
branch_name : nom de la branche (ex: OWL, peuplement)
```

### 2. **validate-sparql-shacl.yml** — Requêtes + Contraintes

| Aspect | Détail |
|--------|--------|
| **Déclenchement auto** | Push/PR sur `queries/`, `shapes/`, `data/` |
| **Validation** | ✓ Syntaxe SPARQL ✓ Syntaxe SHACL ✓ Données vs contraintes |

---

## 🎯 Cas d'usage courant

### Cas 1 : Vous avez fait des changements localement

```bash
# Vous avez modifié ontology/reseau-v0.ttl
git add ontology/reseau-v0.ttl
git commit -m "feat(ontology): Mise à jour classes"
git push

# GitHub Actions automatiquement :
# 1. Lance la validation Turtle
# 2. Décompte concepts
# 3. Valide données (si présentes)
# → Tous les checks passent (ou échouent avec message d'erreur)
```

### Cas 2 : Créer une nouvelle branche pour une phase

**Via interface GitHub :**
1. Actions → ci-ontologie → Run workflow
2. Entrer : phase = `3-formalisation`, branch_name = `OWL`
3. Cliquer "Run workflow"
4. Attendre 30–60 secondes
5. PR #X créée automatiquement

**Via CLI local :**
```bash
.github/scripts/create-phase-branch.sh 3-formalisation OWL
# Crée branche locale, affiche checklist de tâches
# Vous pouvez alors faire vos modifications et pousser
```

### Cas 3 : Ajouter une requête SPARQL (phase 5)

```bash
# Créer requête
echo "SELECT ?s WHERE { ?s a ?type . }" > queries/CQ1.rq

# Pousser
git add queries/CQ1.rq
git commit -m "feat(phase-5): Requête CQ1"
git push

# GitHub Actions automatiquement :
# 1. Valide syntaxe SPARQL (SELECT, CONSTRUCT, ASK, DESCRIBE)
# 2. Vérifie données (si présentes)
# 3. Rapporte succès/erreur
```

### Cas 4 : Ajouter une contrainte SHACL

```bash
# Créer contrainte
cat > shapes/typeSupport.ttl <<'EOF'
@prefix res: <http://example.org/reseau/v0#> .
@prefix sh: <http://www.w3.org/ns/shacl#> .

res:TypeSupportShape
  a sh:NodeShape ;
  sh:targetClass res:Lien ;
  sh:property [
    sh:path res:typeSupport ;
    sh:in ("cuivre" "fibre-monomode" "fibre-multimode") ;
  ] .
EOF

# Pousser
git add shapes/typeSupport.ttl
git commit -m "feat(phase-5): Contrainte SHACL typeSupport"
git push

# GitHub Actions automatiquement :
# 1. Valide syntaxe Turtle
# 2. Valide contrainte SHACL
# 3. Test contre données (si présentes)
```

---

## ✅ Checklist : avant de pousser

**Avant d'appeler un workflow**, vérifier localement :

```bash
# Vérifier syntaxe Turtle
python3 -c "import rdflib; rdflib.Graph().parse('ontology/reseau-v0.ttl', format='turtle'); print('✅')"

# Décompter concepts
python3 - <<'PY'
import rdflib; from rdflib import RDF, OWL
g = rdflib.Graph()
g.parse("ontology/reseau-v0.ttl", format='turtle')
c = len(set(g.subjects(RDF.type, OWL.Class)))
o = len(set(g.subjects(RDF.type, OWL.ObjectProperty)))
print(f"Total: {c} + {o} = {c+o}/50")
PY

# Vérifier git status
git status
```

---

## 🔍 Monitoring et logs

**Voir les résultats d'un workflow :**

1. Aller sur https://github.com/DrOnizuka/OntologieReseauV0/actions
2. Cliquer sur le workflow exécuté
3. Voir le log détaillé par étape

**Les workflows reportent** :
```
✅ — Succès
⚠️  — Avertissement (non-bloquant)
❌ — Erreur (bloquant, le workflow s'arrête)
```

---

## 🐛 Résoudre les erreurs courant

### Erreur : « Syntaxe Turtle invalid »

```
❌ Erreur Turtle: Expected '.' or ';' or ',' or '}'
```

**Solution** :
1. Identifier la ligne (cf. log du workflow)
2. Corriger localement : vérifier les caractères spéciaux, les points-virgules, parenthèses
3. Tester : `python3 -c "import rdflib; rdflib.Graph().parse('ontology/reseau-v0.ttl')"`
4. Repousser

### Erreur : « Dépassement du plafond »

```
❌ DÉPASSEMENT DU PLAFOND
Total: 40 + 15 = 55/50
```

**Solution** :
1. Vérifier que les retraits phase 0 ont été appliqués
2. Lister les classes : `grep "a owl:Class" ontology/reseau-v0.ttl | wc -l`
3. Nettoyer les entités inutiles
4. Repousser

### Erreur : « Pas de clause SPARQL valide »

```
queries/CQ1.rq
  ❌ Pas de clause SPARQL valide
```

**Solution** :
1. Vérifier que la requête commence par `SELECT`, `CONSTRUCT`, `ASK`, ou `DESCRIBE`
2. Exemple valide :
   ```sparql
   PREFIX res: <http://example.org/reseau/v0#>
   SELECT ?s WHERE { ?s a res:Equipement . }
   ```

---

## 🎓 Exemples complets

### Exemple 1 : Créer branche pour phase 3

```bash
# Via CLI
.github/scripts/create-phase-branch.sh 3-formalisation OWL

# Résultat : branche `OWL` créée localement, checklist affichée
```

### Exemple 2 : Ajouter classe en phase 2

```bash
# Modifier docs/modele.md (ajouter classe)
git add docs/modele.md
git commit -m "feat(phase-2): Ajout classe X"
git push origin conceptualisation

# Workflow (auto) :
# ✅ Vérifie syntaxe docs (pas de Turtle à ce stade)
# → PR check passe
```

### Exemple 3 : Compléter phase 3 avec alignement NML

```bash
# Modifier ontology/reseau-v0.ttl (ajouter axiomes NML)
# Tester localement
python3 -c "import rdflib; rdflib.Graph().parse('ontology/reseau-v0.ttl', format='turtle'); print('✅')"

# Pousser
git add ontology/reseau-v0.ttl
git commit -m "feat(phase-3): Alignement NML vérifié"
git push origin OWL

# Workflow (auto) :
# ✅ Syntaxe Turtle
# ✅ Décompte (37/50)
# → PR check passe
```

---

## 🚀 Prochaines étapes

**Pour étendre la CI/CD** :

1. **Ajouter validation HermiT**
   ```yaml
   - name: Valider avec HermiT
     run: docker run -v $(pwd):/work openjdk:11 java -jar hermit.jar /work/ontology/reseau-v0.ttl
   ```

2. **Ajouter déploiement automatique**
   ```yaml
   - name: Déployer sur serveur
     run: |
       ssh user@server "curl -O https://raw.githubusercontent.com/.../ontology/reseau-v0.ttl"
   ```

3. **Ajouter notifications Email en cas d'erreur**
   ```yaml
   - name: Notifier Email
     if: failure()
     uses: dawidd6/action-send-mail@v3
     with:
       server_address: smtp.protonmail.com
       server_port: 587
       username: ${{ secrets.EMAIL_USERNAME }}
       password: ${{ secrets.EMAIL_PASSWORD }}
       subject: "⚠️ Workflow failed: CI Ontologie"
       to: "Dr.Onizuka@protonmail.com"
       from: "github-ci@ontologie-reseau.local"
       body: "Vérifiez les logs : ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}"
   ```

---

## 📞 Aide

Pour revoir la configuration complète :
- **Workflows** : `.github/workflows/`
- **Scripts** : `.github/scripts/`
- **Docs détaillées** : `.github/CI-CD.md`

---

**Généré par** : Claude Code — 2026-08-27
