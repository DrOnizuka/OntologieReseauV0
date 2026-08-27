# Phase 5 — Évaluation & non-régression

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : ⬜ À faire**

## Objectif

Évaluer la qualité de l'ontologie (**Q3**) et mettre en place la **non-régression
(Q4)** : une batterie de tests rejouables (SPARQL + SHACL) garantissant que les
évolutions futures ne cassent rien.

## Entrées

- Ontologie ([phase 3](phase-3-formalisation.md)) + données d'exemple ([phase 4](phase-4-peuplement.md)).
- Questions de compétence ([phase 0](phase-0-cadrage.md)).

## Tâches — Évaluation (Q3)

- [ ] **Couverture** : chaque CQ est-elle satisfaite par le modèle ?
- [ ] **Réutilisation** : les vocabulaires phase 1 sont-ils effectivement mobilisés ?
- [ ] **Pertinence des définitions** : labels/comments clairs, non ambigus, non circulaires.
- [ ] **Cohérence logique** : raisonneur *consistent*, 0 classe incohérente.

## Tâches — Non-régression (Q4)

- [ ] Écrire **une requête SPARQL par CQ** dans `queries/`, avec le **résultat attendu**.
- [ ] Écrire les **contraintes SHACL** (dossier `shapes/` à créer) : formats
  d'adresses, VLAN 1–4094, cardinalités, etc.
- [ ] Définir la procédure de **rejeu** des tests (script/commande).
- [ ] Documenter la correspondance **CQ ↔ requête ↔ résultat attendu**.

## Livrables

- `queries/` complété (une requête par CQ).
- `shapes/` avec les contraintes SHACL.
- Procédure de rejeu documentée + checklist de revue qualité.

## Jalon de validation

📌 **Q3 + Q4 satisfaits** : toutes les CQ ont une requête qui renvoie le
résultat attendu ; les données valident les SHACL ; la suite est rejouable et
documentée.

## Sortie → phase suivante

Les tests verts autorisent la [documentation & release V0](phase-6-documentation-release.md).
