# Phase 2 — Conceptualisation (modèle informel)

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : ✅ Validé** (jalon atteint le 2026-08-27 — modèle conceptuel finalisé)

## Objectif

Construire le **modèle conceptuel** (indépendant du langage OWL) : glossaire des
termes, concepts, relations et attributs, schéma visuel. Vérifier dès ce stade
le respect du **plafond ≤ 50 concepts** et l'absence de hors-périmètre.

## Entrées

- Périmètre & CQ ([phase 0](phase-0-cadrage.md)).
- Vocabulaires à réutiliser ([phase 1](phase-1-existant.md)).

## Tâches

- [x] **Glossaire** : 14 termes métier définis en § 2 de `docs/modele.md`.
- [x] **Concepts (classes candidates)** : 24 classes listées en § 3, chacune rattachée à ≥ 1 CQ.
- [x] **Relations (ObjectProperties candidates)** : 12 ObjectProperties en § 4, domaine/portée validés.
- [x] **Attributs (DatatypeProperties candidates)** : 12 DatatypeProperties en § 5, types XSD et domaines précisés.
- [x] **Schéma** (Mermaid) : hiérarchie complète en § 6, relations principales documentées.
- [x] **Contrôle du plafond** : 24 classes + 12 ObjectProperties = 37 / 50 ✅ (§ 8).
- [x] **Contrôle du périmètre** : vérification exhaustive (§ 10) — aucun concept hors cadrage phase 0 ✅.
- [x] Traçabilité **concept → CQ** : matrice boustrophée phase 3 (CQ → concepts) et (concepts → CQ) en § 9.

## Livrables

- ✅ **Modèle conceptuel finalisé** : `docs/modele.md` (12 sections — glossaire, hiérarchie, schéma Mermaid, traçabilité).
- ✅ **Matrice de couverture** : concept ↔ CQ en § 9 de `docs/modele.md` (deux directions : par CQ et par concept).
- ✅ **Application des décisions phase 0** : retraits sans-fil, ajout LienLAN/LienWAN/porteePar, typeSupport.
- ✅ **Décompte du plafond** : 37 / 50 concepts documenté en § 8.

## Jalon de validation

📌 **Modèle conceptuel validé** ✅ (2026-08-27) :
- ✅ Chaque concept justifié par ≥ 1 CQ.
- ✅ Total 37 / 50 concepts (24 classes + 12 ObjectProperties).
- ✅ 0 élément hors-périmètre (vérification exhaustive § 10 de `docs/modele.md`).
- ✅ Réutilisation des vocabulaires phase 1 respectée (NML, DCMI Terms).
- ✅ Décisions de modélisation phase 0 appliquées et tracées.

## Sortie → phase suivante

Le modèle validé est traduit en OWL en [phase 3](phase-3-formalisation.md).
