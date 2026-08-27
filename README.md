# OntologieReseauV0

Création d'une ontologie réseau **V0** décrivant un réseau informatique / télécom :
équipements, interfaces, liens, réseaux logiques (sous-réseaux, VLAN), adressage,
localisation et services.

Format : **OWL 2 / RDF sérialisé en Turtle**, éditable avec [Protégé](https://protege.stanford.edu/)
et interrogeable en **SPARQL**.

> **Reprendre le travail :** consulter [`TODO.md`](TODO.md) (tâches en attente et avancement des phases) puis la [feuille de route](docs/feuille-de-route.md) — on avance **une phase à la fois**.

## Structure du dépôt

| Dossier / fichier              | Contenu |
|--------------------------------|---------|
| `ontology/reseau-v0.ttl`       | L'ontologie (schéma / TBox) : classes, propriétés |
| `data/exemple-topologie.ttl`   | Instances d'exemple (petite topologie de démo) |
| `queries/exemples.rq`          | Requêtes SPARQL commentées |
| `docs/modele.md`               | Description du modèle conceptuel + points à trancher |
| `CONTRIBUTING.md`              | Conventions de nommage et workflow d'équipe |
| `CHANGELOG.md`                 | Historique des versions |

## Démarrage rapide

**Dans Protégé**
1. `File ▸ Open` → `ontology/reseau-v0.ttl`.
2. `File ▸ Import` (ou ouvrir dans le même espace) → `data/exemple-topologie.ttl`.
3. Lancer un raisonneur (`Reasoner ▸ HermiT ▸ Start`) pour vérifier la cohérence.
4. Onglet *SPARQL Query* pour tester les requêtes de `queries/exemples.rq`.

**En ligne de commande** (avec [Apache Jena](https://jena.apache.org/), optionnel)
```bash
# Validation de la syntaxe Turtle
riot --validate ontology/reseau-v0.ttl data/exemple-topologie.ttl

# Exécuter une requête (Q1) sur ontologie + données
arq --data ontology/reseau-v0.ttl --data data/exemple-topologie.ttl \
    --query <(sed -n '/^SELECT/,/ORDER BY ?type/p' queries/exemples.rq)
```

## Concepts principaux

`Equipement` (Routeur, Commutateur, Pare-feu, Serveur, Point d'accès, Terminal) ·
`Interface` · `Lien` · `Reseau` (Sous-réseau, VLAN) · `Adresse` (IPv4/IPv6/MAC) ·
`Protocole` · `Service` · `Site` · `Zone`.

Voir `docs/modele.md` pour le détail des relations et les choix de modélisation
en cours de discussion.

## Contribuer

Ce dépôt est un support de travail d'équipe. Merci de lire
[`CONTRIBUTING.md`](CONTRIBUTING.md) avant toute modification (conventions de
nommage, vérification par raisonneur, workflow de PR).

## Statut

**V0 — socle initial**, destiné à être discuté et enrichi. Rien n'est figé :
les points ouverts sont listés dans `docs/modele.md § 5`.

Licence : [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
