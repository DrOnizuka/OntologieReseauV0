# Phase 4 — Peuplement d'exemple (ABox)

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : ⬜ À faire**

## Objectif

Créer un **jeu d'instances de démonstration** dans `data/` illustrant une
topologie réaliste et **couvrant les questions de compétence**. Sert de support
aux tests SPARQL/SHACL de la phase 5.

## Entrées

- Ontologie formalisée ([phase 3](phase-3-formalisation.md)).
- Questions de compétence ([phase 0](phase-0-cadrage.md)).

## Tâches

- [ ] Concevoir une topologie d'exemple représentative du périmètre.
- [ ] Créer les individus (préfixe `ex:`), typés par les classes de l'ontologie.
- [ ] Renseigner les relations et attributs pertinents.
- [ ] S'assurer que chaque **CQ** a de quoi être illustrée par les données.
- [ ] Garder l'exemple **minimal mais suffisant** (lisible).

## Vérification

```bash
python3 -c "import rdflib;g=rdflib.Graph();g.parse('ontology/reseau-v0.ttl');g.parse('data/exemple-topologie.ttl');print(len(g),'triples')"
```

## Livrable

- `data/exemple-topologie.ttl` (ou fichiers d'instances dédiés).

## Jalon de validation

📌 Les instances **se chargent sans erreur** avec le schéma, et couvrent
l'ensemble des CQ (chaque CQ pourra recevoir une requête en phase 5).

## Sortie → phase suivante

Les données alimentent l'[évaluation & non-régression](phase-5-evaluation.md).
