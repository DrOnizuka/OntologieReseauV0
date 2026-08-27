# CLAUDE.md — Référence agent pour OntologieReseauV0

Ce dépôt construit une **ontologie du réseau informatique** en OWL 2 / Turtle,
en travail d'équipe. Ce fichier est la référence à charger avant toute action.
Il **résume** les règles ; la source de vérité détaillée est
`docs/consignes-construction.md`.

## Règles non négociables

1. **Plafond : ≤ 50 concepts** = `classes + ObjectProperties` (les
   DatatypeProperties ne comptent pas). Approcher 50 → généraliser, pas accumuler.
   Tout dépassement doit être décidé en équipe et tracé dans `CHANGELOG.md`.
2. **Périmètre strict = réseau informatique.** Aucun concept hors périmètre,
   même « au cas où ». Le cadrage fin est défini dans l'ORSD/`docs/modele.md`.
3. **Phase préalable obligatoire avant de modéliser** — répondre à :
   - Q1 ontologies/représentations existantes (reprise/écartée **+ justification**, garder la trace),
   - Q2 utilisateur cible et ses compétences,
   - Q3 comment vérifier la cohérence (couverture, réutilisation, définitions, raisonneur),
   - Q4 comment vérifier la non-régression (SPARQL / SHACL rejouables).
4. **Piloté par les questions de compétence** : pas de classe/propriété sans ≥1 CQ.
5. **Individus → `data/` uniquement**, jamais dans `ontology/` (schéma/TBox).

## Structure

| Chemin | Rôle |
|--------|------|
| `ontology/reseau-v0.ttl` | Schéma (TBox) — l'ontologie (brouillon, cf. Statut) |
| `data/*.ttl` | Instances d'exemple (ABox) |
| `queries/*.rq` | Requêtes SPARQL (dont tests de non-régression) |
| `docs/consignes-construction.md` | **Consignes détaillées (source de vérité)** |
| `docs/feuille-de-route.md` | Feuille de route NeOn en 7 phases + jalons |
| `docs/phases/phase-N-*.md` | Fiche de travail d'une phase (objectif, tâches, jalon) |
| `docs/modele.md` | Modèle courant + décisions ouvertes |
| `docs/inventaire-fichiers.md` | Inventaire des fichiers et de leur utilité |
| `TODO.md` | Tâches différées (« à faire plus tard ») |
| `CONTRIBUTING.md` | Workflow Git + conventions de nommage |
| `CHANGELOG.md` | Historique versionné |

## Conventions (rappel)

- Turtle uniquement. Classes `PascalCase` fr, propriétés `camelCase` fr.
- `rdfs:label`@fr + `rdfs:comment`@fr sur toute entité ; `rdfs:domain`/`rdfs:range` obligatoires.
- Espace de noms actuel `http://example.org/reseau/v0#` = **placeholder** (ne pas changer sans décision d'équipe).

## Vérifications avant toute PR

```bash
# 1. Syntaxe Turtle
python3 -c "import rdflib,sys;[rdflib.Graph().parse(f) for f in sys.argv[1:]]" \
  ontology/reseau-v0.ttl data/exemple-topologie.ttl

# 2. Décompte du plafond (classes + ObjectProperties ≤ 50)
python3 - <<'PY'
import rdflib; from rdflib import RDF, OWL
g=rdflib.Graph(); g.parse("ontology/reseau-v0.ttl")
c=len(set(g.subjects(RDF.type,OWL.Class))); o=len(set(g.subjects(RDF.type,OWL.ObjectProperty)))
print(f"{c} classes + {o} objprops = {c+o}/50")
PY

# 3. Cohérence : ouvrir dans Protégé, lancer HermiT → 0 classe incohérente.
# 4. Non-régression : rejouer les requêtes de queries/ (résultats attendus).
```

## Statut

**Phase 0–1 non encore formalisées** (cadrage + étude de l'existant). Le
`.ttl` présent (37 concepts) est un **brouillon exploratoire**, pas la V0
validée. Voir la feuille de route pour l'ordre des étapes.

## Pratiques du projet

Habitudes de travail à respecter (autant par les agents que par l'équipe) :

- **Progression pas à pas** : on suit `docs/feuille-de-route.md`, **une phase à
  la fois**. Une phase ne s'ouvre que si le **jalon** de la précédente est validé.
  L'avancement se consigne dans la fiche `docs/phases/phase-N-*.md` correspondante
  et dans le tableau de statut de la feuille de route.
- **Tâches différées → `TODO.md`** : toute tâche « à faire plus tard » (dette,
  point à trancher, amélioration) est enregistrée dans `TODO.md` — jamais perdue
  dans une conversation. On coche/retire les items une fois faits.
- **Documentation synchronisée** : quand le modèle change, mettre à jour
  `docs/modele.md` et `CHANGELOG.md`. Quand des fichiers sont ajoutés/retirés,
  mettre à jour `docs/inventaire-fichiers.md`.
- **Décisions tracées** : tout arbitrage d'équipe (périmètre, plafond, namespace,
  réutilisation) est consigné (CHANGELOG / fiche de phase / doc concernée) avec
  sa justification.

## Règles de collaboration

- **Ne pas committer/pousser sans demande explicite** de l'utilisateur.
- `.env` contient des secrets : **jamais** le committer (déjà dans `.gitignore`).
- Vérifier avant PR : syntaxe, plafond ≤ 50, cohérence raisonneur, non-régression
  (voir section ci-dessus).
