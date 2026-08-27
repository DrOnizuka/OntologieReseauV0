# Changelog

Toutes les évolutions notables de l'ontologie sont consignées ici.
Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/) ;
versionnage sémantique de l'ontologie (`owl:versionInfo`).

## [0.1.0] — 2026-08-27

### Ajouté
- Socle initial de l'ontologie (`ontology/reseau-v0.ttl`) :
  - Classes : `ElementReseau` et sous-classes `Equipement` (Routeur, Commutateur,
    PareFeu, Serveur, PointAccesSansFil, Terminal), `Interface`
    (Physique/Logique), `Lien` (Filaire/SansFil), `Reseau` (SousReseau, VLAN),
    `Adresse` (IPv4/IPv6/MAC), `Protocole`, `Service`, `Site`, `Zone`.
  - Propriétés d'objet : `possedeInterface`/`interfaceDe`, `aExtremite`,
    `connecteA`, `appartientAuReseau`, `aAdresse`, `localiseA`/`heberge`,
    `appartientAZone`, `fournitService`, `utiliseProtocole`.
  - Propriétés de données : `nom`, `identifiant`, `fabricant`, `modele`,
    `versionLogiciel`, `actif`, `numeroPort`, `debitMbps`, `valeurAdresse`,
    `prefixeCIDR`, `adresseReseau`, `numeroVLAN`.
  - Axiomes de disjonction sur les types d'équipements et d'adresses.
- Topologie d'exemple (`data/exemple-topologie.ttl`).
- Requêtes SPARQL d'exemple (`queries/exemples.rq`).
- Documentation du modèle (`docs/modele.md`), guide de contribution et README.
