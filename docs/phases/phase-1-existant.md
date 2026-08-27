# Phase 1 — Étude de l'existant & réutilisation

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : ✅ Validé** (jalon atteint le 2026-08-27 — tableau des sources arrêté)

## Objectif

Répondre à **Q1** : recenser les ontologies et représentations structurées de la
connaissance existantes sur le réseau informatique, et décider ce qui est
**repris ou écarté** — en gardant la trace (et la justification) même des
sources non retenues. Éviter de réinventer, maximiser l'interopérabilité.

## Entrées

- Périmètre & 19 CQ validés en [phase 0](phase-0-cadrage.md).

## Tâches

- [x] Recenser les **ontologies** réseau candidates.
- [x] Recenser les **autres représentations** utiles (schémas CMDB, modèles de
  données, normes, taxonomies, vocabulaires).
- [x] Pour chaque source : évaluer couverture vs. notre périmètre, maturité,
  licence, interopérabilité.
- [x] **Décider** : reprise / partiellement reprise / écartée + **justification**.
- [x] Conserver la trace des **sources écartées** et du pourquoi.
- [x] Trancher la **stratégie de réutilisation** (import / alignement / inspiration).

## Grille d'évaluation retenue

Chaque source est jugée sur : **couverture** de nos 19 CQ · **maturité** et
maintenance · **licence** · **format** (OWL/RDF ou non) · **coût de
réutilisation** au regard du plafond de 50 concepts et du périmètre strict.

Un critère domine : notre périmètre est **volontairement plus étroit** que
celui de toutes les sources recensées (pas de supervision, pas de temporalité,
pas de virtualisation). Importer une source large ferait donc **entrer du
hors-périmètre**, ce que la règle 2 des consignes interdit.

## Recensement — **arrêté**

### A. Ontologies OWL / RDF du domaine réseau

| Source | Couvre quoi | Maturité / licence | Évaluation vs. notre périmètre | Décision |
|---|---|---|---|---|
| **NML — Network Markup Language** ([OGF GFD.206](https://ogf.org/documents/GFD.206.pdf)) | Topologie réseau : `Topology`, `Node`, `Port`, `Link`, `BidirectionalPort`, `Label`. Deux syntaxes normatives : XSD **et OWL** | Standard OGF publié, adopté dans les réseaux de recherche (NSI, ESnet) | **Le recouvrement le plus direct** : `Node`/`Port`/`Link` ≡ nos `Equipement`/`Interface`/`Lien`. Mais modèle **unidirectionnel** (deux ports par interface physique), complexité qu'aucune de nos CQ ne réclame. Ne couvre ni L3/adressage, ni services, ni sites | **Partiellement repris** — alignement `rdfs:subClassOf` de nos 3 classes pivots sur les classes **bidirectionnelles** de NML, sans `owl:imports` (cf. §2) |
| **NORIA-O** ([Orange-OpenSource](https://github.com/Orange-OpenSource/noria-ontology), [`w3id.org/noria/ontology/`](https://w3id.org/noria/ontology/)) | Réseaux IT **+ événements + opérations** (ITSM), pour graphe de connaissances et détection d'anomalies | Active, industrielle (Orange), **BSD-4-Clause**, RDF/OWL/SKOS | Ontologie de référence francophone la plus proche. Mais son cœur — **incidents, événements, temporalité, exploitation** — est explicitement **hors de notre périmètre** (exclusions phase 0). L'importer ferait entrer tout ce qu'on a exclu | **Écartée à l'import, retenue comme référence de conception** ; alignement ponctuel possible sur la partie topologie |
| **ToCo (TOUCAN Ontology)** ([ESWC 2019](https://link.springer.com/chapter/10.1007/978-3-030-21348-0_33), [GitHub](https://github.com/QianruZhou333/toco_ontology)) | Réseaux télécom hétérogènes : infrastructure physique, qualité de canal, services, utilisateurs. **84 concepts, 39 object properties** | Académique (ESWC 2019) ; maintenance et licence **à vérifier** | Apporte le **motif DIL — Device / Interface / Link**, qui valide notre triptyque. Mais 84 concepts contre un plafond de 50, et QoS/utilisateurs hors périmètre | **Écartée à l'import ; motif DIL repris** comme justification de notre structure |
| **NDL / INDL** (Univ. d'Amsterdam) | Ancêtre de NML (NDL) et extension virtualisation + calcul (INDL) | NDL superseded par NML ; INDL académique | NDL est remplacé par NML → sans objet. INDL porte la **virtualisation**, explicitement exclue en phase 0 | **Écartées** (obsolète / hors périmètre) |

### B. Modèles de données et normes — non-ontologiques

| Source | Couvre quoi | Maturité / licence | Évaluation vs. notre périmètre | Décision |
|---|---|---|---|---|
| **IETF YANG — [RFC 8345](https://www.rfc-editor.org/rfc/rfc8345.html)** (`ietf-network`, `ietf-network-topology`), **RFC 8346** (topologies L3), **RFC 8343** (interfaces) | Modèle abstrait de topologie et d'inventaire réseau : `network`, `node`, `termination-point`, `link` ; augmenté par couche | **Standards Track IETF** (2018), libre d'usage | Le standard de fait côté équipementiers. Même structure que la nôtre, **mais en YANG, pas en RDF** : aucun alignement formel possible, seulement un alignement documentaire. Couvre L3 et les interfaces, ce que NML ne fait pas | **Cité comme norme**, non retenu comme référence de travail (redondant avec l'alignement NML — cf. §3) |
| **DMTF CIM** ([dmtf.org/standards/cim](https://www.dmtf.org/standards/cim)) | Modèle de management systèmes/réseaux/applications ; socle historique des CMDB (dont CMDBf) | Standard DMTF mature, spécification libre | Très large et orienté **instrumentation/management**, loin de notre finalité documentaire. Volume incompatible avec 50 concepts | **Écartée** ; consultée pour le vocabulaire CMDB |
| **NetBox — modèle DCIM/IPAM** ([doc des modèles](https://netboxlabs.com/docs/netbox/development/models/)) | `Site`, `Rack`, `Device`, `Interface`, `Cable`, `VLAN`, `Prefix`, `IPAddress`, `Circuit` | Outil open source de référence (« source of truth » réseau), Apache 2.0 | **Le périmètre fonctionnel le plus proche du nôtre** : c'est exactement une CMDB réseau L1–L3. Mais c'est un schéma relationnel Django, **pas un vocabulaire RDF** | **Retenu comme checklist de couverture** pour la phase 2 (a-t-on oublié un concept que toute CMDB réseau porte ?) — jamais comme modèle à copier |

### C. Vocabulaires génériques transverses

| Source | Usage envisagé chez nous | Décision |
|---|---|---|
| **[SKOS](https://www.w3.org/TR/skos-reference/)** | Porter les **vocabulaires contrôlés** : valeurs de `typeSupport` (CQ19), types de zone (CQ14) | **Écarté de la V0** — incompatible avec `typeSupport` en DatatypeProperty (cf. §3) ; `sh:in` SHACL suffit pour trois valeurs. Piste V1 |
| **[DCMI Terms](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/)** | Métadonnées de l'ontologie elle-même : `creator`, `license`, `created`, `modified` | **Retenu** — usage standard, hors modèle métier |
| **RDFS / OWL / XSD** | Socle du langage | **Retenu** (implicite) |
| **PROV-O**, **GeoSPARQL / WGS84**, **schema.org** | Traçabilité temporelle · géolocalisation des sites · vocabulaire généraliste | **Écartés** : la temporalité est hors périmètre (phase 0) ; `Site` est un simple rattachement documentaire, sans géométrie ; schema.org est trop imprécis pour un usage technique |

### Pistes non explorées (à trancher si le temps le permet)

- **IANAifType-MIB / IF-MIB (RFC 2863)** — liste de codes normalisée des types
  d'interface. Pourrait fournir le vocabulaire contrôlé de CQ19/CQ2 plutôt que
  d'en inventer un. *À vérifier en phase 2.*
- **TM Forum SID** — modèle d'information télécom ; réputé très volumineux et
  orienté opérateur/facturation, a priori hors de notre échelle.
- **Vocabulaires SEAS** (motif générique système/connexion) — à vérifier.

## Décisions arrêtées (2026-08-27)

### 1. Stratégie de réutilisation : **alignement léger**

Nos classes restent **définies chez nous** ; le lien aux sources externes passe
par des axiomes `rdfs:subClassOf` / `owl:equivalentClass` vers leurs URI.

*Justification.* Coût **nul** sur le plafond de 50 (les entités externes ne sont
pas déclarées chez nous), interopérabilité réelle pour les agents IA — l'un de
nos utilisateurs cibles (Q2) —, et périmètre entièrement maîtrisé. Les deux
autres options sont écartées : `owl:imports` ferait entrer les concepts
hors-périmètre de la source importée et rendrait le raisonnement dépendant
d'une ontologie tierce (contraire à la règle 2 des consignes) ; l'inspiration
purement documentaire renoncerait à l'interopérabilité machine.

*Contrainte induite.* Tout alignement devra être vérifié au raisonneur en
**phase 3** : un alignement faux est un moyen classique de rendre une ontologie
incohérente.

### 2. NML : alignement des trois classes pivots

| Notre classe | Classe NML visée | Axiome |
|---|---|---|
| `Equipement` | `nml:Node` | `rdfs:subClassOf` |
| `Interface` | `nml:BidirectionalPort` | `rdfs:subClassOf` |
| `Lien` | `nml:BidirectionalLink` | `rdfs:subClassOf` |

*Justification.* NML est le seul standard **OWL** qui recouvre notre cœur de
modèle. L'objection du modèle unidirectionnel se résout en visant les classes
**bidirectionnelles** de NML plutôt que `nml:Port`/`nml:Link` : notre
`Interface` est bidirectionnelle par nature, l'aligner sur `nml:Port`
(unidirectionnel) aurait été une **équivalence fausse**.

`rdfs:subClassOf` est préféré à `owl:equivalentClass` : nos classes portent des
contraintes propres au périmètre CMDB que NML n'impose pas ; affirmer une
équivalence stricte serait plus fort que ce qu'on peut démontrer.

Nous **n'adoptons pas** la décomposition unidirectionnelle de NML (deux ports
par interface) : aucune de nos 19 CQ ne la réclame et elle doublerait le
volume d'instances.

> ⚠️ **À vérifier en phase 3** : l'existence et l'URI exactes de
> `nml:BidirectionalPort` et `nml:BidirectionalLink` dans
> [GFD.206](https://ogf.org/documents/GFD.206.pdf), ainsi que l'espace de noms
> NML à employer. L'alignement ne sera écrit qu'une fois ces URI confirmées.

### 3. Vocabulaires transverses

| Vocabulaire | Décision | Justification |
|---|---|---|
| **DCMI Terms** | **Retenu** | Métadonnées de l'ontologie (`creator`, `license`, `created`, `modified`). Hors modèle métier, coût nul. |
| **NetBox** (modèle DCIM/IPAM) | **Retenu comme checklist de couverture** en phase 2 | Périmètre fonctionnel le plus proche du nôtre. Sert à *questionner* le modèle (« a-t-on oublié un concept que toute CMDB réseau porte ? »), **jamais à le copier** : NetBox est plus riche que nous (racks, circuits, tenants, VRF) et le recopier ferait exploser le plafond de 50. |
| **RFC 8345 / 8346 / 8343** | **Cité comme norme, non retenu comme référence de travail** | Modèle délibérément abstrait (`network`/`node`/`termination-point`/`link`), donc largement redondant avec l'alignement NML déjà décidé. Nommage anglais et YANG-isé, sans prise sur nos conventions françaises. La citation suffit à la traçabilité. |
| **SKOS** | **Écarté de la V0** | Incompatible avec la décision de phase 0 de faire de `typeSupport` une **DatatypeProperty** : une valeur SKOS est une ressource, pas un littéral, ce qui imposerait une ObjectProperty (+1 concept). Pour un vocabulaire de trois valeurs, une contrainte SHACL `sh:in` suffit. Reversé en piste V1 dans `TODO.md` si le vocabulaire s'étoffe ou doit devenir multilingue. |

## Livrable — tableau des sources

Le recensement ci-dessus tient lieu de livrable ; les colonnes « Décision »
sont figées. Les sources **écartées** y restent inscrites avec leur motif,
conformément à Q1 (on garde la trace même de ce qu'on ne reprend pas).

## Jalon de validation

📌 **Tableau des sources arrêté** ✅ — décisions de réutilisation justifiées,
vocabulaires figés (DCMI Terms + alignement NML ; NetBox en checklist),
stratégie choisie (**alignement léger**). Ces choix contraignent la
conceptualisation : on ne redéfinit pas un concept d'une source reprise, et
tout nouvel alignement devra repasser par cette phase.

## Sortie → phase suivante

Les vocabulaires retenus alimentent la [conceptualisation](phase-2-conceptualisation.md).
