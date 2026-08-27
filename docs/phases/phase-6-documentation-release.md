# Phase 6 — Documentation & release V0

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : ⬜ À faire**

## Objectif

Finaliser la documentation, figer l'espace de noms pérenne et **publier la V0**
(version taguée), cohérente et prête pour l'équipe.

## Entrées

- Tests d'évaluation & non-régression verts ([phase 5](phase-5-evaluation.md)).

## Tâches

- [ ] Mettre `docs/modele.md` en cohérence avec le `.ttl` final.
- [ ] Compléter le `CHANGELOG.md` (version 0.1.0, décisions tracées).
- [ ] Mettre à jour le `README.md` (concepts, démarrage, statut « V0 publiée »).
- [ ] **Figer l'espace de noms pérenne** (remplacer le placeholder `example.org`) — décision d'équipe.
- [ ] Vérifier `owl:versionIRI` / `owl:versionInfo` dans l'en-tête de l'ontologie.
- [ ] Revue finale + relecture d'équipe.
- [ ] **Taguer** la release Git.

## Vérification finale

- [ ] Syntaxe OK, plafond ≤ 50, raisonneur *consistent*.
- [ ] Tests SPARQL/SHACL de non-régression verts.
- [ ] Documentation cohérente avec l'ontologie.

## Livrables

- Documentation à jour + `CHANGELOG.md`.
- Tag Git `v0.1.0`.

## Jalon de validation

📌 **Release V0 publiée** : tag `v0.1.0` poussé, documentation cohérente avec le
`.ttl`, espace de noms pérenne figé.

## Après la V0

Toute évolution repart de la [phase 2](phase-2-conceptualisation.md) et repasse
par la [non-régression](phase-5-evaluation.md) avant fusion.
