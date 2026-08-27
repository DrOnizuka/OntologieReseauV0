# TODO — Tâches à traiter plus tard

Tâches différées, à reprendre au bon moment (souvent rattachées à une phase de
la [feuille de route](docs/feuille-de-route.md)). Cocher une fois faites.

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
