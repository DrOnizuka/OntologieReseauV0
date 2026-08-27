# TODO — Tâches à traiter plus tard

Tâches différées, à reprendre au bon moment (souvent rattachées à une phase de
la [feuille de route](docs/feuille-de-route.md)). Cocher une fois faites.

> **Point d'entrée pour reprendre le travail.** En début de session, lire ce
> fichier et traiter la première tâche non cochée de la section « Avancement
> des phases ».

## Avancement des phases (feuille de route)

- [ ] **Clôturer la phase 0 — Cadrage** : valider les questions de compétence
  (brouillon de 15 CQ dans [`docs/phases/phase-0-cadrage.md`](docs/phases/phase-0-cadrage.md)).
  Périmètre et utilisateurs déjà arrêtés → il ne reste que la validation des CQ. → *phase 0 (🟡 en cours)*.
- [ ] **Phase 1 — Étude de l'existant & réutilisation** : recenser les
  ontologies/représentations réseau, décider reprise/écartée + justification. → *après clôture phase 0*.
- [ ] **Phase 2 — Conceptualisation** : modèle informel (glossaire, concepts,
  relations, schéma), contrôle du plafond ≤ 50 et du périmètre. Réécrire `docs/modele.md`.
- [ ] **Phase 3 — Formalisation OWL** : reprendre/valider `ontology/reseau-v0.ttl`
  (parse + raisonneur *consistent*).
- [ ] **Phase 4 — Peuplement d'exemple** : mettre `data/` en cohérence avec le modèle validé.
- [ ] **Phase 5 — Évaluation & non-régression** : une requête SPARQL par CQ +
  contraintes SHACL (dossier `shapes/` à créer).
- [ ] **Phase 6 — Documentation & release V0** : doc à jour, namespace pérenne,
  tag `v0.1.0`.

> Règle : une phase ne s'ouvre que si le **jalon** de la précédente est validé
> (voir [`docs/feuille-de-route.md`](docs/feuille-de-route.md)). Mettre à jour le
> statut de la phase (fiche + tableau de la feuille de route) au fur et à mesure.

## Cohérence / dette documentaire

- [ ] **Requalifier `CHANGELOG.md`** : la « [0.1.0] » y est présentée comme
  livrée alors que le `.ttl` est un brouillon exploratoire. La marquer
  « pré-V0 / brouillon » jusqu'à la vraie release. → *à faire en phase 6, ou avant si besoin de clarté*.
- [ ] **Marquer comme provisoires** `ontology/reseau-v0.ttl`,
  `data/exemple-topologie.ttl` et `docs/modele.md` (brouillons produits avant
  le cadrage). → *rattaché aux phases 2–3–4*.
- [ ] **Réécrire `docs/modele.md`** à l'issue de la conceptualisation. → *phase 2*.

## Découvrabilité

- [ ] Ajouter un lien vers `docs/inventaire-fichiers.md` depuis `README.md`
  et/ou `CLAUDE.md` (décision en attente).

## À trancher en équipe (rappel)

- [ ] Figer l'**espace de noms pérenne** (remplacer `http://example.org/reseau/v0#`). → *phase 6*.
- [ ] Décider si les **DatatypeProperties** comptent dans le plafond de 50
  (actuellement : non). → *à confirmer*.

## Sécurité

- [ ] **Révoquer et régénérer le token GitHub** exposé en conversation, puis
  mettre à jour `.env` (idéalement un token *fine-grained* limité au repo).
