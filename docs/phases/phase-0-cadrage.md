# Phase 0 — Cadrage & spécification (ORSD)

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : ⬜ À faire**

## Objectif

Produire le **document de spécification des besoins** (ORSD, *Ontology
Requirements Specification Document* — NeOn) : cadrer finement le périmètre,
identifier l'utilisateur cible (**Q2**) et fixer les questions de compétence.
C'est le socle qui autorise (ou refuse) chaque concept par la suite.

## Entrées

- `docs/consignes-construction.md`
- Brouillon exploratoire `ontology/reseau-v0.ttl` (comme matière de départ)

## Tâches

- [ ] **Finalité de l'ontologie** : à quoi doit-elle servir (documentation/CMDB, supervision, sécurité, conception… ) ?
- [ ] **Périmètre fin « réseau informatique »** :
  - [ ] Niveau(x) couvert(s) : physique / liaison (L2) / réseau (L3) / services ?
  - [ ] Échelle : LAN, datacenter, WAN, cloud ?
  - [ ] **Exclusions explicites** (ce qu'on ne modélise PAS).
- [ ] **Q2 — Utilisateur cible** : profils, compétences (web sémantique ? SPARQL ? lecture seule ?), mode d'interaction attendu.
- [ ] **Questions de compétence (CQ)** : lister les questions auxquelles l'ontologie devra répondre (viser un jeu représentatif).
- [ ] **Rappel des contraintes** : plafond ≤ 50 concepts, périmètre strict.

## Livrables

- Section **Périmètre & exclusions** dans `docs/modele.md` (ou ORSD dédié).
- Liste des **profils utilisateurs**.
- Liste initiale des **CQ** (réutilisable en phase 5 pour les requêtes).

## Jalon de validation

📌 **Spécification validée en équipe** : périmètre écrit noir sur blanc,
profils utilisateurs identifiés, jeu de CQ arrêté. Sans ce jalon, la phase 1
ne s'ouvre pas.

## Sortie → phase suivante

Le périmètre et les CQ conditionnent l'[étude de l'existant](phase-1-existant.md).
