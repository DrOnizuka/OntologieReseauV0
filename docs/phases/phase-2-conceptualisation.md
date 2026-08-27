# Phase 2 — Conceptualisation (modèle informel)

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : ⬜ À faire**

## Objectif

Construire le **modèle conceptuel** (indépendant du langage OWL) : glossaire des
termes, concepts, relations et attributs, schéma visuel. Vérifier dès ce stade
le respect du **plafond ≤ 50 concepts** et l'absence de hors-périmètre.

## Entrées

- Périmètre & CQ ([phase 0](phase-0-cadrage.md)).
- Vocabulaires à réutiliser ([phase 1](phase-1-existant.md)).

## Tâches

- [ ] **Glossaire** : définir chaque terme métier en langage clair.
- [ ] **Concepts (classes candidates)** : chacun rattaché à ≥ 1 CQ.
- [ ] **Relations (ObjectProperties candidates)** : domaine / portée pressentis.
- [ ] **Attributs (DatatypeProperties candidates)** : type de valeur pressenti.
- [ ] **Schéma** (Mermaid) de la hiérarchie et des relations.
- [ ] **Contrôle du plafond** : `classes + ObjectProperties ≤ 50`.
- [ ] **Contrôle du périmètre** : aucun concept hors du cadrage phase 0.
- [ ] Traçabilité **concept → CQ** (matrice de couverture).

## Livrables

- Modèle conceptuel documenté dans `docs/modele.md` (glossaire + schéma + relations).
- Matrice de couverture concept ↔ CQ.

## Jalon de validation

📌 **Modèle conceptuel validé** : chaque concept justifié par ≥ 1 CQ, total
≤ 50, aucun élément hors-périmètre, réutilisation des vocabulaires phase 1
respectée.

## Sortie → phase suivante

Le modèle validé est traduit en OWL en [phase 3](phase-3-formalisation.md).
