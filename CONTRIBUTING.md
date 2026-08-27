# Guide de contribution — OntologieReseauV0

Merci de lire ces conventions avant de contribuer. L'objectif est de garder
l'ontologie cohérente et facile à faire évoluer à plusieurs.

## Outils recommandés

- **[Protégé](https://protege.stanford.edu/)** (5.5+) pour éditer l'ontologie
  et lancer le raisonneur (HermiT / Pellet) — vérifier la **cohérence** avant
  chaque commit.
- Un triplestore ou l'onglet *SPARQL Query* de Protégé pour tester les requêtes.
- Sérialisation **Turtle (`.ttl`)** imposée : lisible et diff-friendly dans Git.

## Organisation du dépôt

```
OntologieReseauV0/
├── ontology/   # l'ontologie (schéma / TBox)   → reseau-v0.ttl
├── data/       # instances d'exemple (ABox)     → exemple-topologie.ttl
├── queries/    # requêtes SPARQL d'exemple
├── docs/       # documentation du modèle
├── CHANGELOG.md
└── CONTRIBUTING.md
```

## Conventions de nommage

- **Classes** : `PascalCase`, en français, au singulier — `Routeur`, `SousReseau`.
- **Propriétés** : `camelCase`, en français — `possedeInterface`, `numeroVLAN`.
  Objet = verbe/relation ; données = nom d'attribut.
- **Instances** (dans `data/`) : préfixe `ex:`, identifiant explicite — `ex:R1-PARIS`.
- Toujours ajouter `rdfs:label` **@fr** et, si utile, `rdfs:comment` **@fr**.
- `skos:altLabel` pour les synonymes / termes anglais courants (`Switch`, `Firewall`).

## Espace de noms (namespace)

L'IRI de base `http://example.org/reseau/v0#` est un **placeholder**. Ne pas le
changer unilatéralement : le passage à un IRI pérenne (ex. `https://w3id.org/...`)
doit faire l'objet d'une décision d'équipe (impact sur tous les fichiers).

## Workflow Git

1. Créer une branche par sujet : `feat/ajout-classe-vpn`, `fix/domain-aAdresse`.
2. Faire des commits atomiques, messages en français à l'impératif :
   `Ajoute la classe PareFeu`.
3. **Avant de pousser** : ouvrir dans Protégé, lancer le raisonneur, vérifier
   qu'il n'y a **pas de classe incohérente** (aucune classe équivalente à `owl:Nothing`).
4. Ouvrir une *Pull Request*, décrire le changement de modèle et son intention.
5. Au moins **une relecture** avant fusion.

## Checklist avant PR

- [ ] Le fichier `.ttl` se charge sans erreur de parsing.
- [ ] Le raisonneur ne signale aucune incohérence.
- [ ] Toute nouvelle entité a un `rdfs:label`@fr.
- [ ] `docs/modele.md` mis à jour si le modèle change.
- [ ] `CHANGELOG.md` complété.
- [ ] Domaine/portée renseignés pour les nouvelles propriétés.

## Versionnage

Versionnage sémantique de l'ontologie via `owl:versionInfo` / `owl:versionIRI`
dans l'en-tête. Reporter chaque changement notable dans `CHANGELOG.md`.
