# TODO — Tâches à traiter plus tard

Tâches différées, à reprendre au bon moment (souvent rattachées à une phase de
la [feuille de route](docs/feuille-de-route.md)). Cocher une fois faites.

> **Point d'entrée pour reprendre le travail.** En début de session, lire ce
> fichier et traiter la première tâche non cochée de la section « Avancement
> des phases ».

## Avancement des phases (feuille de route)

- [x] **Clôturer la phase 0 — Cadrage** : périmètre, utilisateurs et **19 CQ**
  validés le 2026-08-27 (voir [`docs/phases/phase-0-cadrage.md`](docs/phases/phase-0-cadrage.md)). → *phase 0 (✅ validée)*.
- [x] **Phase 1 — Étude de l'existant & réutilisation** : tableau des sources
  arrêté le 2026-08-27, stratégie d'**alignement léger** retenue
  (voir [`docs/phases/phase-1-existant.md`](docs/phases/phase-1-existant.md)). → *phase 1 (✅ validée)*.
- [x] **Phase 2 — Conceptualisation** ✅ (2026-08-27) : modèle conceptuel finalisé dans `docs/modele.md`.
  Glossaire, concepts, relations, attributs, schéma Mermaid, traçabilité CQ, contrôle du plafond (37/50) et du périmètre.
  Décisions de modélisation appliquées (retraits sans-fil + `LienFilaire`, ajout `LienLAN`/`LienWAN`, `porteePar`, `typeSupport`).
  **Jalon : prêt pour phase 3 (formalisation OWL)**.
- [x] **Phase 3 — Formalisation OWL** — Turtle écrit et validé (syntaxe, plafond) :
  - [x] Turtle complet : 25 classes + 12 ObjectProperties + 12 DatatypeProperties
  - [x] Métadonnées DCMI Terms en en-tête
  - [x] Alignements NML commentés (en attente de vérification GFD.206)
  - [x] Syntaxe ✅, plafond 37/50 ✅
  - [ ] Raisonneur : HermiT dans Protégé → *à faire (pas d'outil local)* 
  - [ ] Vérification URIs NML → *en attente de GFD.206*
- [ ] **Phase 4 — Peuplement d'exemple** : mettre `data/` en cohérence avec le modèle validé.
- [ ] **Phase 5 — Évaluation & non-régression** : une requête SPARQL par CQ +
  contraintes SHACL (dossier `shapes/` à créer).
- [ ] **Phase 6 — Documentation & release V0** : doc à jour, namespace pérenne,
  tag `v0.1.0`.

> Règle : une phase ne s'ouvre que si le **jalon** de la précédente est validé
> (voir [`docs/feuille-de-route.md`](docs/feuille-de-route.md)). Mettre à jour le
> statut de la phase (fiche + tableau de la feuille de route) au fur et à mesure.

## Suites de la validation des CQ (phase 0 → phases 2-3-4)

- [x] **Trancher le sort de `actif`** (DatatypeProperty) — **RETIRÉ** en phase 2. Aucune CQ le couvre ; la règle « pas de propriété sans ≥ 1 CQ » s'applique. Ne sera jamais ajouté à `ontology/reseau-v0.ttl`.
- [ ] **Désambiguïser `numeroPort`** : le brouillon l'emploie pour le port
  physique (`InterfacePhysique`), alors que CQ13 réclame le **port de transport**
  d'un service. Deux propriétés distinctes, nommées sans ambiguïté. → *phase 3*.
- [ ] **Contrainte SHACL sur `typeSupport`** : vocabulaire fermé
  (cuivre, fibre-monomode, fibre-multimode) porté par CQ19. → *phase 5*.
- [ ] **Retyper `data/exemple-topologie.ttl:109`** : instance de `res:LienFilaire`,
  classe supprimée → `LienLAN` ou `LienWAN`. → *phase 4*.

## Suites de la phase 1 (réutilisation)

- [ ] **Vérifier les URI NML** dans [GFD.206](https://ogf.org/documents/GFD.206.pdf)
  avant d'écrire l'alignement : existence et forme exactes de
  `nml:BidirectionalPort` / `nml:BidirectionalLink`, et espace de noms NML à
  employer. Aucun axiome d'alignement n'est écrit tant que ce n'est pas confirmé. → *phase 3*.
- [ ] **Contrôler les alignements au raisonneur** : un alignement erroné est une
  cause classique d'incohérence. → *phase 3*.
- [ ] **Passer le modèle au crible de NetBox** (Site, Device, Interface, Cable,
  VLAN, Prefix, IPAddress) comme contrôle de complétude — sans recopier son
  périmètre plus large (racks, circuits, tenants, VRF). → *phase 2*.
- [ ] **Déclarer les métadonnées DCMI Terms** sur l'ontologie
  (`creator`, `license`, `created`, `modified`). → *phase 3, complété en phase 6*.
- [ ] *(V1, si besoin)* **Reconsidérer SKOS** pour les vocabulaires contrôlés si
  `typeSupport` doit s'étoffer ou devenir multilingue — impliquerait de le
  passer en ObjectProperty (+1 concept).
- [ ] *(optionnel)* Vérifier **IANAifType-MIB / IF-MIB (RFC 2863)** comme source
  de vocabulaire normalisé pour les types d'interface / de support. → *phase 2*.

## Cohérence / dette documentaire

- [x] **Requalifier `CHANGELOG.md`** : la « [0.1.0] » est désormais marquée
  « ⚠️ brouillon pré-V0 (non validé) ». Le tag `v0.1.0` sera posé en phase 6.
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

- [ ] **Révoquer et régénérer le token GitHub** exposé en conversation.
- [ ] **Migrer l'authentification** vers SSH (recommandé) ou un credential helper
  git, en suivant la section *Setup* du skill `git-push-secure`. Une fois fait,
  le token dans `.env` n'est plus nécessaire pour pousser → **retirer
  `GIT_PASSWORD` du `.env`**.
