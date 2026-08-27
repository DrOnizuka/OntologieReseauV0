# Inventaire des fichiers du projet

État au **2026-08-27**. Ce document recense tous les fichiers du dépôt, leur
rôle et leur utilité. À tenir à jour quand la structure évolue.

Légende verdict :
- ✅ **Utile** — à garder tel quel.
- 🟡 **Utile mais à surveiller** — statut ambigu, incohérence, ou à retravailler dans une phase à venir.
- ❌ **Inutile / à supprimer** — (aucun à ce jour).

## Racine

| Fichier | Rôle | Verdict | Remarque / action |
|---------|------|---------|-------------------|
| `README.md` | Point d'entrée : présentation, structure, démarrage Protégé/Jena | ✅ | Reflète l'état actuel. À réaligner en phase 6. |
| `CLAUDE.md` | Référence agent : règles non négociables, renvoie aux consignes | ✅ | Source de vérité déléguée à `docs/consignes-construction.md`. |
| `CONTRIBUTING.md` | Workflow Git + conventions de nommage | ✅ | — |
| `CHANGELOG.md` | Historique versionné | 🟡 | **Incohérence** : décrit une « [0.1.0] » comme livrée, alors que la feuille de route classe le `.ttl` en *brouillon exploratoire* (phases 0–1 non faites). À requalifier en « pré-V0 / brouillon » jusqu'à la vraie release (phase 6). |
| `.gitignore` | Exclusions Git (dont `.env`, backups Protégé) | ✅ | — |
| `.env` | Identifiants Git locaux (secrets) | ✅ | Local, **jamais commité**. Contient un token à révoquer/renouveler (exposé en conversation). |
| `.env.example` | Modèle de `.env` sans secret, pour l'équipe | ✅ | — |

## `ontology/` — schéma (TBox)

| Fichier | Rôle | Verdict | Remarque / action |
|---------|------|---------|-------------------|
| `ontology/reseau-v0.ttl` | Ontologie OWL/Turtle (37 concepts : 26 classes + 11 ObjectProperties) | 🟡 | **Statut ambigu** : nommée `-v0` mais c'est un **brouillon exploratoire** produit avant le cadrage (phases 0–1). À reprendre/valider en phases 2–3. Syntaxe valide, sous le plafond de 50. |

## `data/` — instances (ABox)

| Fichier | Rôle | Verdict | Remarque / action |
|---------|------|---------|-------------------|
| `data/exemple-topologie.ttl` | Topologie de démonstration (77 triplets) | 🟡 | Utile pour tester, mais **dépend du brouillon** `reseau-v0.ttl` : évoluera avec lui (phase 4). |

## `queries/` — requêtes

| Fichier | Rôle | Verdict | Remarque / action |
|---------|------|---------|-------------------|
| `queries/exemples.rq` | 6 requêtes SPARQL commentées (Q1 active, Q2–Q6 en commentaire) | ✅ | Base des tests de non-régression (phase 5). À relier explicitement aux questions de compétence. |

## `docs/` — documentation

| Fichier | Rôle | Verdict | Remarque / action |
|---------|------|---------|-------------------|
| `docs/consignes-construction.md` | **Consignes de construction (source de vérité)** : règles, plafond 50, Q1–Q4 | ✅ | Document central. |
| `docs/feuille-de-route.md` | Feuille de route NeOn en 7 phases, avec jalons et statuts | ✅ | — |
| `docs/modele.md` | Description du modèle courant + décisions ouvertes | 🟡 | Décrit le **brouillon** ; sera réécrit lors de la conceptualisation (phase 2). Référencé par les consignes (§ décisions ouvertes). |
| `docs/inventaire-fichiers.md` | **Ce document** : inventaire et utilité des fichiers | ✅ | À maintenir à jour. |

### `docs/phases/` — fiches de travail (une par phase)

| Fichier | Rôle | Verdict |
|---------|------|---------|
| `phase-0-cadrage.md` | Cadrage & spécification (ORSD) | ✅ |
| `phase-1-existant.md` | Étude de l'existant & réutilisation | ✅ |
| `phase-2-conceptualisation.md` | Conceptualisation (modèle informel) | ✅ |
| `phase-3-formalisation.md` | Formalisation OWL | ✅ |
| `phase-4-peuplement.md` | Peuplement d'exemple (ABox) | ✅ |
| `phase-5-evaluation.md` | Évaluation & non-régression | ✅ |
| `phase-6-documentation-release.md` | Documentation & release V0 | ✅ |

## Synthèse

- **20 fichiers**, tous ont une utilité. Aucun candidat à la suppression.
- **3 points de vigilance (🟡)** :
  1. `CHANGELOG.md` présente une V0 comme livrée → à requalifier en brouillon.
  2. `ontology/reseau-v0.ttl` (+ `data/exemple-topologie.ttl`) = brouillon
     exploratoire, à valider via les phases 2–3–4, pas encore la V0 officielle.
  3. `docs/modele.md` décrit ce brouillon → sera réécrit en phase 2.
- **Recommandation de cohérence** : tant que la V0 n'est pas validée (phase 6),
  traiter `ontology/`, `data/` et `docs/modele.md` comme du **provisoire**, et
  aligner le `CHANGELOG.md` en conséquence.
