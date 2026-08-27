# Changelog

Toutes les évolutions notables de l'ontologie sont consignées ici.
Format inspiré de [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/) ;
versionnage sémantique de l'ontologie (`owl:versionInfo`).

## [Non publié]

### Décidé — 2026-08-27 · clôture de la phase 1 (étude de l'existant, Q1)
- **Jalon phase 1 validé** : tableau des sources arrêté
  (`docs/phases/phase-1-existant.md`), sources écartées conservées avec leur motif.
- **Stratégie de réutilisation : alignement léger.** Nos classes restent définies
  chez nous, reliées aux sources externes par `rdfs:subClassOf` / `owl:equivalentClass`.
  `owl:imports` écarté : il ferait entrer les concepts hors périmètre de la source
  importée et échapperait au plafond de 50.
- **Alignement NML retenu** sur les trois classes pivots — `Equipement` →
  `nml:Node`, `Interface` → `nml:BidirectionalPort`, `Lien` → `nml:BidirectionalLink`.
  Les classes **bidirectionnelles** de NML sont visées plutôt que `nml:Port` /
  `nml:Link` : aligner notre `Interface` bidirectionnelle sur un `Port`
  unidirectionnel aurait été une équivalence fausse. `rdfs:subClassOf` préféré à
  `owl:equivalentClass`, plus prudent. URI exactes à confirmer en phase 3.
- **DCMI Terms retenu** pour les métadonnées de l'ontologie.
- **NetBox retenu comme checklist de couverture** pour la phase 2 — à utiliser
  pour questionner le modèle, jamais pour le copier (périmètre plus large).
- **RFC 8345 / 8346 / 8343 cités comme normes** mais non retenus comme référence
  de travail : redondants avec l'alignement NML, nommage YANG sans prise sur nos
  conventions françaises.
- **SKOS écarté de la V0** : incompatible avec `typeSupport` en DatatypeProperty
  (une valeur SKOS est une ressource, pas un littéral) ; une contrainte SHACL
  `sh:in` suffit pour trois valeurs. Reversé en piste V1.
- **Écartées** : NORIA-O (cœur incidents/événements/temporalité hors périmètre,
  retenue comme référence de conception), ToCo (84 concepts > plafond ; motif
  Device-Interface-Link repris conceptuellement), NDL (obsolète), INDL
  (virtualisation), DMTF CIM (volume, orientation instrumentation), PROV-O,
  GeoSPARQL/WGS84, schema.org.

### Décidé — 2026-08-27 · clôture de la phase 0 (cadrage)
- **Jalon phase 0 validé** : périmètre, exclusions, profils utilisateurs et
  **19 questions de compétence** arrêtés (`docs/phases/phase-0-cadrage.md`).
  Les CQ passent de 15 (brouillon) à 19 ; numérotation stable, les CQ ajoutées
  portent les numéros 16 à 19.
- **CQ ajoutées** : CQ16 (adressage IPv4 vs IPv6), CQ17 (interfaces logiques
  portées par une interface physique), CQ18 (ports physiques libres),
  CQ19 (support physique d'un lien).
- **CQ précisées** : CQ6 marquée *dérivée* ; CQ7 explicitement fondée sur une
  appartenance **assertée** et non calculée depuis le CIDR ; CQ13 étendue au
  port de transport ; CQ15 élargie au **type** d'équipement.
- **Décisions de modélisation** pour les phases 2–3–4, avec justification :
  retrait de `PointAccesSansFil` et `LienSansFil` (sans-fil hors périmètre) et
  de `LienFilaire` (extension devenue universelle, ne partitionne plus rien) ;
  ajout de la partition disjointe `LienLAN` / `LienWAN` (porte CQ11) ; ajout de
  `porteePar` (porte CQ17) ; ajout de `typeSupport` en DatatypeProperty avec
  vocabulaire fermé SHACL (porte CQ19).
- **Règle de modélisation retenue** : un seul axe de partition en sous-classes
  par classe ; tout axe supplémentaire passe en propriété, pour éviter
  l'explosion combinatoire des sous-classes.
- **Budget prévisionnel** : 37 − 3 + 2 + 1 = **37 / 50 concepts**.

---

## [0.1.0] — 2026-08-27 — ⚠️ brouillon pré-V0 (non validé)

> Cette entrée décrit un **socle exploratoire produit avant le cadrage**
> (phases 0–1). Il ne constitue **pas** la V0 livrée : il sera repris et validé
> en phases 2–3–4. La vraie release portera le tag `v0.1.0` en phase 6.

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
