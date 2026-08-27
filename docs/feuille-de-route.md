# Feuille de route — Ontologie Réseau Informatique

Feuille de route de construction, alignée sur la méthode **NeOn** et sur les
règles de `docs/consignes-construction.md`. On procède **pas à pas** : une phase
n'est ouverte que lorsque le **jalon** de la précédente est validé.

Chaque phase dispose d'un document de travail dédié dans `docs/phases/`.

## Vue d'ensemble

| # | Phase | Fiche de travail | Jalon de validation | Statut |
|---|-------|------------------|---------------------|--------|
| 0 | Cadrage & spécification (ORSD) | [phase-0-cadrage.md](phases/phase-0-cadrage.md) | Spécification validée : périmètre + CQ + utilisateurs | ⬜ À faire |
| 1 | Étude de l'existant & réutilisation | [phase-1-existant.md](phases/phase-1-existant.md) | Tableau des sources décidé (reprise/écartée + raison) | ⬜ À faire |
| 2 | Conceptualisation (modèle informel) | [phase-2-conceptualisation.md](phases/phase-2-conceptualisation.md) | Modèle validé, ≤ 50 concepts, 0 hors-périmètre | ⬜ À faire |
| 3 | Formalisation OWL (Turtle) | [phase-3-formalisation.md](phases/phase-3-formalisation.md) | `.ttl` parse + raisonneur *consistent* | ⬜ À faire |
| 4 | Peuplement d'exemple (ABox) | [phase-4-peuplement.md](phases/phase-4-peuplement.md) | Instances chargées sans erreur | ⬜ À faire |
| 5 | Évaluation & non-régression | [phase-5-evaluation.md](phases/phase-5-evaluation.md) | CQ couvertes (SPARQL) + SHACL valide | ⬜ À faire |
| 6 | Documentation & release V0 | [phase-6-documentation-release.md](phases/phase-6-documentation-release.md) | Tag `v0.1.0`, doc cohérente | ⬜ À faire |

Légende statut : ⬜ à faire · 🟡 en cours · ✅ validé.

## Principe de progression

1. On ouvre **une** phase à la fois.
2. On remplit sa fiche de travail (`docs/phases/`).
3. On valide le **jalon** en équipe (ou par les vérifications automatiques).
4. On met à jour le statut dans ce tableau + le `CHANGELOG.md`.
5. On ouvre la phase suivante.

## Boucle d'évolution

Après la release V0, toute évolution du modèle repasse par les phases **2 → 5**
(conceptualisation → non-régression), garantissant qu'on ne casse pas l'existant.

## État actuel

Un socle `ontology/reseau-v0.ttl` (37 concepts) existe déjà mais a été produit
**avant** les phases 0–1 : il est traité comme **brouillon exploratoire**, à
reprendre/valider une fois le cadrage et l'étude de l'existant faits.

> **Prochaine étape : Phase 0 — Cadrage & spécification.**
