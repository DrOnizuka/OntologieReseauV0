# Feuille de route — Ontologie Réseau Informatique

Feuille de route de construction, alignée sur la méthode **NeOn** et sur les
règles de `docs/consignes-construction.md`. On procède **pas à pas** : une phase
n'est ouverte que lorsque le **jalon** de la précédente est validé.

Chaque phase dispose d'un document de travail dédié dans `docs/phases/`.

## Vue d'ensemble

| # | Phase | Fiche de travail | Jalon de validation | Statut |
|---|-------|------------------|---------------------|--------|
| 0 | Cadrage & spécification (ORSD) | [phase-0-cadrage.md](phases/phase-0-cadrage.md) | Spécification validée : périmètre + CQ + utilisateurs | ✅ Validé |
| 1 | Étude de l'existant & réutilisation | [phase-1-existant.md](phases/phase-1-existant.md) | Tableau des sources décidé (reprise/écartée + raison) | ✅ Validé |
| 2 | Conceptualisation (modèle informel) | [phase-2-conceptualisation.md](phases/phase-2-conceptualisation.md) | Modèle validé, ≤ 50 concepts, 0 hors-périmètre | 🟡 En cours |
| 3 | Formalisation OWL (Turtle) | [phase-3-formalisation.md](phases/phase-3-formalisation.md) | `.ttl` parse + raisonneur *consistent* | 🟡 En cours |
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

**Phase 0 validée le 2026-08-27** : périmètre et exclusions arrêtés, profils
utilisateurs identifiés, **19 questions de compétence** figées (voir
[phase-0-cadrage.md](phases/phase-0-cadrage.md)). La validation a aussi produit
des **décisions de modélisation** à appliquer en phases 2–3–4, avec un budget
prévisionnel de **37 / 50 concepts**.

Un socle `ontology/reseau-v0.ttl` (37 concepts) existe déjà mais a été produit
**avant** les phases 0–1 : il reste un **brouillon exploratoire**, à
reprendre/valider une fois l'étude de l'existant faite.

**Phase 1 validée le 2026-08-27** : tableau des sources arrêté (voir
[phase-1-existant.md](phases/phase-1-existant.md)). Stratégie retenue :
**alignement léger** (pas d'`owl:imports`), alignement `rdfs:subClassOf` de nos
trois classes pivots sur **NML**, **DCMI Terms** pour les métadonnées, **NetBox**
en checklist de couverture. SKOS écarté de la V0.

**Phase 2 en cours** : modèle conceptuel finalisé dans `docs/modele.md` — 37/50 concepts,
19 CQ couvertes, périmètre validé, décisions de modélisation appliquées (retrait sans-fil,
ajout LienLAN/LienWAN, porteePar pour CQ17, typeSupport pour CQ19).
