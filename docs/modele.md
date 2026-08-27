# Modèle conceptuel — Ontologie Réseau V0

**Statut : Phase 2 — Conceptualisation (en cours)**

Ce document décrit le modèle conceptuel finalisé en phase 2. Il sera ensuite
traduit en OWL (phase 3) et implémenté en Turtle (`ontology/reseau-v0.ttl`).

> **Traces de validation** : 
> - Périmètre et CQ : [phase-0-cadrage.md](phases/phase-0-cadrage.md)
> - Vocabulaires réutilisés : [phase-1-existant.md](phases/phase-1-existant.md)
> - Décisions de modélisation appliquées : phase-0 § « Décisions de modélisation induites »

---

## 1. Périmètre

**Périmètre** : Décrire un **réseau informatique et télécom** — équipements (L1–L7), 
leur raccordement physique (L1, L2) et logique (L3, L7), l'adressage et la localisation.

**Niveaux couverts** :
- **L1 (physique)** : câblage, ports, sites, support du lien
- **L2 (liaison)** : VLAN, adresses MAC, commutation
- **L3 (réseau)** : adresses IP (v4/v6), sous-réseaux, routeurs
- **L7 (services)** : services applicatifs (DNS, DHCP, web…)

**Échelle** : LAN d'entreprise + WAN / opérateur (interconnexion de sites).

**Exclusions explicites** (hors champ V0) :
- Métrologie / supervision temps réel (métriques, état live)
- Configuration détaillée (ACL, tables de routage, protocoles de routage)
- Historique / dimension temporelle
- Virtualisation, cloud, overlays
- **Réseau sans fil** (Wi-Fi, points d'accès, liens radio)
- Raisonnement sécurité (seules zones documentaires conservées)

> **Point clé** : exclure n'est pas nier. L'ontologie ne parle simplement pas de 
> ces domaines.

---

## 2. Glossaire des termes métier

| Terme | Définition | CQ(s) |
|-------|-----------|-------|
| **Équipement** | Dispositif actif raccordé au réseau (routeur, commutateur, serveur, pare-feu, terminal). | CQ1, CQ15 |
| **Interface** | Point de connexion d'un équipement au réseau — physique (port matériel) ou logique (virtuelle). | CQ2, CQ4, CQ5, CQ17 |
| **Lien** | Connexion physique reliant deux interfaces — filaire par défaut, partitionnée en LAN/WAN. | CQ3, CQ11, CQ19 |
| **Lien LAN** | Lien reliant deux équipements sur le même site ou réseau local. | CQ3, CQ11 |
| **Lien WAN** | Lien reliant deux sites ou réseaux distants (opérateur, backbone). | CQ11 |
| **Réseau logique** | Regroupement d'interfaces selon une plage d'adressage ou un identifiant VLAN. | CQ4, CQ7, CQ8 |
| **Sous-réseau** | Réseau IP défini par une adresse de base et un préfixe CIDR (ex. 192.168.10.0/24). | CQ7, CQ8 |
| **VLAN** | Réseau local virtuel de couche 2, identifié par un numéro (802.1Q, 1–4094). | CQ4, CQ6 |
| **Adresse** | Identifiant d'adressage (IP ou MAC) porté par une interface. | CQ5, CQ7, CQ16 |
| **Service** | Service applicatif exposé par un équipement (DNS, DHCP, HTTP…). | CQ12, CQ13 |
| **Protocole** | Protocole de communication utilisé par un service (HTTPS, DNS…). ⚠️ Non les protocoles de routage. | CQ13 |
| **Site** | Localisation physique hébergeant des équipements (bâtiment, salle, datacenter). | CQ1, CQ11 |
| **Zone** | Regroupement documentaire pour segmentation (DMZ, LAN interne, WAN). Pas de sémantique sécurité. | CQ14 |

---

## 3. Hiérarchie des concepts (classes)

### Vue globale

```
ElementReseau (racine)
├── Equipement
│   ├── Routeur
│   ├── Commutateur
│   ├── PareFeu
│   ├── Serveur
│   └── Terminal
├── Interface
│   ├── InterfacePhysique
│   └── InterfaceLogique
├── Lien
│   ├── LienLAN
│   └── LienWAN
├── Reseau
│   ├── SousReseau
│   └── VLAN
├── Adresse
│   ├── AdresseIP
│   │   ├── AdresseIPv4
│   │   └── AdresseIPv6
│   └── AdresseMAC
├── Service
└── Protocole

Site (standalone — contexte de localisation)
Zone (standalone — segmentation documentaire)
```

### Décisions de modélisation appliquées

D'après [phase-0-cadrage.md](phases/phase-0-cadrage.md) § « Décisions de modélisation induites » :

| Décision | Justification | Effet | Status |
|----------|---------------|-------|--------|
| **Retirer** `PointAccesSansFil` | Sans-fil hors périmètre | −1 classe | ✅ Appliqué |
| **Retirer** `LienSansFil` | Sans-fil hors périmètre | −1 classe | ✅ Appliqué |
| **Retirer** `LienFilaire` | Extension universelle, ne partitionne plus rien | −1 classe | ✅ Appliqué |
| **Ajouter** `LienLAN` + `LienWAN` | Porte CQ11 ; remplace la partition filaire/sans-fil par la seule partition utile (LAN vs WAN) | +2 classes | ✅ Appliqué |
| **Ajouter** `porteePar` (ObjectProperty) | Relie InterfaceLogique → InterfacePhysique. Porte CQ17. | +1 ObjectProperty | ✅ Appliqué |
| **Conserver** `AdresseIPv4` / `AdresseIPv6` | Justifiées par CQ16 (distinction IPv4 vs IPv6). | 0 | ✅ Conservé |
| **Conserver** `Service`, `Protocole` | L7 dans le périmètre (CQ12, CQ13). | 0 | ✅ Conservé |
| **Conserver** `Zone` | Segmentation documentaire, pas sémantique sécurité. CQ14. | 0 | ✅ Conservé |
| **Ajouter** `typeSupport` (DatatypeProperty) | Vocabulaire fermé (cuivre, fibre-monomode, fibre-multimode) en SHACL. Porte CQ19. | 0 (DatatypeProperty) | ✅ Appliqué |
| **Retirer** `actif` (DatatypeProperty) | Aucune CQ ne le couvre depuis écartement de « éléments hors service ». Règle : pas de propriété sans ≥ 1 CQ. | 0 (DatatypeProperty) | ✅ Retiré |

**Budget résultant** : 37 / 50 concepts (13 places de marge).

---

## 4. Relations (ObjectProperties)

Chaque relation est documentée avec son domaine, sa portée et sa justification par une CQ.

| ObjectProperty | Domaine | Portée | Caractéristiques | CQ(s) | Commentaire |
|---|---|---|---|---|---|
| `possedeInterface` | Equipement | Interface | — | CQ2 | Un équipement expose des interfaces (1-à-N). |
| `interfaceDe` | Interface | Equipement | Functional | CQ2, CQ4, CQ5 | Inverse de `possedeInterface` ; chaque interface appartient à exactement 1 équipement. |
| `aExtremite` | Lien | Interface | — | CQ3 | Extrémités d'un lien (typiquement 2 interfaces, l'implémentation contraindra). |
| `connecteA` | Interface | Interface | Symmetric | CQ10 | Adjacence directe symétrique : si A connecté à B, alors B connecté à A. |
| `porteePar` | InterfaceLogique | InterfacePhysique | — | CQ17 | Relie une interface logique (VLAN, sub-interface) à sa physique porteuse. |
| `appartientAuReseau` | Interface | Reseau | — | CQ4, CQ8 | Rattache une interface à un sous-réseau ou VLAN. |
| `aAdresse` | Interface | Adresse | — | CQ5, CQ7, CQ16 | Adresse (IP ou MAC) portée par une interface (1-à-N pour les plages IP). |
| `localiseA` | Equipement | Site | Functional | CQ1 | Chaque équipement est hébergé sur exactement 1 site (1-à-1). |
| `heberge` | Site | Equipement | — | CQ1 | Inverse de `localiseA` (N-à-1 côté site). |
| `appartientAZone` | Equipement | Zone | — | CQ14 | Zone de segmentation de l'équipement (documentaire). |
| `fournitService` | Equipement | Service | — | CQ12 | Services exposés par un équipement. Typiquement Serveur ou Infrastructure. |
| `utiliseProtocole` | ElementReseau | Protocole | — | CQ13 | Protocole mis en œuvre par un élément du réseau (Service, Equipement, Interface). |

**Total ObjectProperties** : 12

**Note sur `connecteA`** : relie deux interfaces. Coexiste avec `aExtremite` (rôle du lien réifié) ; 
la relation entre instances pourrait être dérivée en phase 5 via une règle SHACL ou SWRL.

---

## 5. Attributs (DatatypeProperties)

| DatatypeProperty | Domaine | Type XSD | Cardinalité | CQ(s) | Commentaire |
|---|---|---|---|---|---|
| `nom` | ElementReseau | xsd:string | 0–1 | — | Nom courant ou hostname. |
| `identifiant` | ElementReseau | xsd:string | 0–1 | CQ15 | Identifiant technique unique (inventaire, CMDB). |
| `fabricant` | Equipement | xsd:string | 0–1 | CQ15 | Nom du fabricant (Cisco, Juniper, etc.). |
| `modele` | Equipement | xsd:string | 0–1 | CQ15 | Modèle du dispositif. |
| `versionLogiciel` | Equipement | xsd:string | 0–1 | CQ15 | Version firmware/OS. |
| `numeroPort` | InterfacePhysique | xsd:integer | 0–1 | CQ2 | Numéro du port physique. Ambiguïté connue : le port de service (CQ13) sera modélisé différemment. ⚠️ |
| `debitMbps` | Interface, Lien | xsd:decimal | 0–1 | CQ2, CQ3 | Débit nominal en Mbit/s. |
| `valeurAdresse` | Adresse | xsd:string | 0–1 | CQ5, CQ7 | Représentation textuelle (ex. 192.168.1.1, 00:1A:2B:3C:4D:5E). |
| `adresseReseau` | SousReseau | xsd:string | 0–1 | CQ8 | Adresse de base du sous-réseau (ex. 192.168.10.0). |
| `prefixeCIDR` | SousReseau | xsd:integer | 0–1 | CQ8 | Longueur du préfixe (ex. 24 pour /24). |
| `numeroVLAN` | VLAN | xsd:integer | 1 | CQ4 | Identifiant 802.1Q (1–4094). |
| `typeSupport` | Lien | xsd:string | 0–1 | CQ19 | Vocabulaire fermé : { cuivre, fibre-monomode, fibre-multimode }. ⚠️ Contrainte SHACL en phase 5. |

**Total DatatypeProperties** : 12 (ne comptent pas dans le plafond de 50).

**⚠️ Ambiguïtés à trancher** (cf. TODO.md) :
1. **`numeroPort`** : actuellement pour le port physique (CQ2). CQ13 réclame le port de transport (TCP/UDP) d'un service. 
   → Créer une deuxième propriété `portTransport` ou similaire. À décider en phase 3.
2. **`typeSupport`** : vocabulaire fermé porté par SHACL. Trois valeurs suffisent pour V0 (pas besoin de SKOS). 
   Évolutivité : passer à SKOS en V1 si étoffe.

---

## 6. Concepts non organisés en hiérarchie

### `Site`
- **Définition** : Localisation physique.
- **Justification** : CQ1, CQ11.
- **Statut** : Classe standalone (n'hérite pas de ElementReseau) — c'est un contexte, pas un élément du réseau lui-même.
- **Relations** : `localiseA` (←), `heberge` (→).

### `Zone`
- **Définition** : Regroupement documentaire pour segmentation (DMZ, LAN, WAN).
- **Justification** : CQ14.
- **Statut** : Classe standalone — segmentation purement documentaire, pas de sémantique de sécurité.
- **Relations** : `appartientAZone` (←).

---

## 7. Schéma conceptuel (Mermaid)

```mermaid
graph TD
    ElementReseau["<b>ElementReseau</b><br/>(racine)"]
    
    ElementReseau --> Equipement
    ElementReseau --> Interface
    ElementReseau --> Lien
    ElementReseau --> Reseau
    ElementReseau --> Adresse
    ElementReseau --> Service
    ElementReseau --> Protocole
    
    Equipement --> Routeur["Routeur<br/>(CQ9)"]
    Equipement --> Commutateur["Commutateur<br/>(CQ4, CQ6)"]
    Equipement --> PareFeu["PareFeu"]
    Equipement --> Serveur["Serveur<br/>(CQ12)"]
    Equipement --> Terminal["Terminal"]
    
    Interface --> InterfacePhysique["InterfacePhysique<br/>(CQ2, CQ18)"]
    Interface --> InterfaceLogique["InterfaceLogique<br/>(CQ17)"]
    
    Lien --> LienLAN["LienLAN<br/>(CQ3, CQ11)"]
    Lien --> LienWAN["LienWAN<br/>(CQ11)"]
    
    Reseau --> SousReseau["SousReseau<br/>(CQ7, CQ8)"]
    Reseau --> VLAN["VLAN<br/>(CQ4, CQ6)"]
    
    Adresse --> AdresseIP["AdresseIP"]
    Adresse --> AdresseMAC["AdresseMAC<br/>(CQ5)"]
    
    AdresseIP --> AdresseIPv4["AdresseIPv4<br/>(CQ16)"]
    AdresseIP --> AdresseIPv6["AdresseIPv6<br/>(CQ16)"]
    
    Service:::important["<b>Service</b><br/>(CQ12, CQ13)"]
    Protocole:::important["<b>Protocole</b><br/>(CQ13)"]
    
    Site:::context["<b>Site</b><br/>(CQ1, CQ11)"]
    Zone:::context["<b>Zone</b><br/>(CQ14)"]
    
    classDef important fill:#fff3cd
    classDef context fill:#e8f4f8
```

**Relations principales** (omises du schéma pour clarté) :
- `Equipement` --possedeInterface--> `Interface`
- `Interface` --aExtremite--> `Lien`
- `Interface` --connecteA--> `Interface` (symétrique)
- `Interface` --aAdresse--> `Adresse`
- `Equipement` --localiseA--> `Site`
- `Equipement` --appartientAZone--> `Zone`
- `Service` <--fournitService-- `Equipement`
- `ElementReseau` --utiliseProtocole--> `Protocole`

---

## 8. Contrôle du plafond

**Plafond autorisé** : ≤ 50 concepts (classes + ObjectProperties).
Les DatatypeProperties ne comptent pas.

### Décompte : Étapes successives

#### 1. Brouillon initial (avant phase 0)
- **37 concepts** (25 classes + 12 ObjectProperties) — source : phase-0-cadrage.md.

#### 2. Application des décisions de modélisation (phase 0 → phase 2)

| Modification | Δ classes | Δ ObjectProperties | Justification |
|---|---|---|---|
| **Retrait** `PointAccesSansFil` | −1 | — | Sans-fil hors périmètre |
| **Retrait** `LienSansFil` | −1 | — | Sans-fil hors périmètre |
| **Retrait** `LienFilaire` | −1 | — | Devient universel, ne partitionne plus |
| **Ajout** `LienLAN` | +1 | — | Remplace partition filaire/sans-fil par LAN/WAN utile |
| **Ajout** `LienWAN` | +1 | — | Idem |
| **Ajout** `porteePar` (ObjectProperty) | — | +1 | Relie InterfaceLogique → InterfacePhysique (CQ17) |

**Sous-total** :
```
Brouillon    : 25 classes + 12 ObjectProperties = 37
Retraits     : −3 classes                       = −3
Ajouts       : +2 classes + 1 ObjectProperty    = +3
Nouveau total: 24 classes + 13 ObjectProperties = 37
```

#### 3. Décompte final par catégorie

**Classes** (24) :
1. ElementReseau
2. Equipement
3. Routeur
4. Commutateur
5. PareFeu
6. Serveur
7. Terminal
8. Interface
9. InterfacePhysique
10. InterfaceLogique
11. Lien
12. LienLAN
13. LienWAN
14. Reseau
15. SousReseau
16. VLAN
17. Adresse
18. AdresseIP
19. AdresseIPv4
20. AdresseIPv6
21. AdresseMAC
22. Service
23. Protocole
24. Site *(contextuel, ne dérive pas d'ElementReseau)*

**ObjectProperties** (13) :
1. possedeInterface
2. interfaceDe
3. aExtremite
4. connecteA
5. porteePar *(nouveau)*
6. appartientAuReseau
7. aAdresse
8. localiseA
9. heberge
10. appartientAZone
11. fournitService
12. utiliseProtocole
13. (Zone n'a pas d'inverse nommé, `appartientAZone` lui suffit)

**Total** : 24 + 13 = **37 / 50** ✅

**Marge disponible** : 50 − 37 = **13 concepts**

---

## 9. Matrice de traçabilité concept ↔ CQ

Chaque concept est justifié par ≥ 1 CQ. Réciproquement, chaque CQ sera couverte par une requête SPARQL en phase 5.

### Par CQ

| CQ | Énoncé | Concepts requis | Classes | ObjectProperties |
|---|---|---|---|---|
| **CQ1** | Quels équipements sont hébergés sur un site donné ? | Site, Equipement, localisation | Equipement, Site | localiseA, heberge |
| **CQ2** | Quels sont les ports physiques d'un équipement et leur débit ? | Equipement, Interface physique, débit | Equipement, InterfacePhysique | possedeInterface, interfaceDe |
| **CQ3** | Quel lien physique relie deux équipements (et par quelles interfaces) ? | Lien, Interface, équipement | Lien, LienLAN, LienWAN, InterfacePhysique | aExtremite, interfaceDe |
| **CQ4** | Quelles interfaces appartiennent à un VLAN donné ? | Interface, VLAN, réseau logique | Interface, VLAN | appartientAuReseau |
| **CQ5** | Quelle est l'adresse MAC d'une interface ? | Interface, Adresse MAC | Interface, AdresseMAC | aAdresse |
| **CQ6** | Quels équipements partagent un même VLAN ? | Equipement, VLAN, Interface (dérivée) | Equipement, VLAN, Interface | possedeInterface, appartientAuReseau |
| **CQ7** | Quelles adresses IP sont utilisées dans un sous-réseau donné ? | Adresse IP, Sous-réseau, Interface | AdresseIP, SousReseau | aAdresse, appartientAuReseau |
| **CQ8** | À quel sous-réseau (adresse/masque) appartient une interface ? | Interface, Sous-réseau, CIDR | Interface, SousReseau | appartientAuReseau |
| **CQ9** | Quels routeurs interconnectent quels sous-réseaux ? | Routeur, Sous-réseau, Interface | Routeur, SousReseau, Interface | appartientAuReseau |
| **CQ10** | Quels équipements sont directement adjacents à un équipement donné ? | Equipement, Interface, adjacence | Equipement, Interface | possedeInterface, connecteA |
| **CQ11** | Quels liens WAN relient deux sites ? | Lien WAN, Site, Interface | LienWAN, Site, Interface | aExtremite, localiseA |
| **CQ12** | Quels services sont fournis par un serveur donné ? | Serveur, Service | Serveur, Service | fournitService |
| **CQ13** | Quel protocole et quel port de transport sont associés à un service donné ? | Service, Protocole, port ⚠️ | Service, Protocole | utiliseProtocole |
| **CQ14** | Quels équipements appartiennent à une zone donnée (ex. DMZ) ? | Equipement, Zone | Equipement, Zone | appartientAZone |
| **CQ15** | Lister les équipements par type, fabricant, modèle, version logicielle. | Equipement (spécialisations), attributs | Routeur, Commutateur, PareFeu, Serveur, Terminal | — |
| **CQ16** | Quels équipements / interfaces sont adressés en IPv6 (vs IPv4) ? | Interface, Adresse IPv4/IPv6 | Interface, AdresseIPv4, AdresseIPv6 | aAdresse |
| **CQ17** | Quelles interfaces logiques sont portées par une interface physique donnée ? | InterfaceLogique, InterfacePhysique, porteage | InterfaceLogique, InterfacePhysique | porteePar |
| **CQ18** | Quels ports physiques d'un équipement ne sont raccordés à aucun lien (ports libres) ? | InterfacePhysique, Lien, adjacence | InterfacePhysique, Lien | aExtremite |
| **CQ19** | Quel est le support physique d'un lien (cuivre, fibre monomode, fibre multimode) ? | Lien, typeSupport | Lien, LienLAN, LienWAN | — |

### Par concept

| Classe / Propriété | Couvertes par | Justification |
|---|---|---|
| **Equipement** | CQ1, CQ2, CQ6, CQ9, CQ10, CQ12, CQ14, CQ15 | Pivot central. |
| **Routeur** | CQ9, CQ15 | Interconnexion L3. |
| **Commutateur** | CQ4, CQ6, CQ15 | L2, VLAN. |
| **PareFeu** | CQ15 | Type d'équipement. |
| **Serveur** | CQ12, CQ15 | Services. |
| **Terminal** | CQ15 | Type d'équipement. |
| **Interface** | CQ2, CQ3, CQ4, CQ5, CQ6, CQ7, CQ8, CQ9, CQ10, CQ17, CQ18 | Pivot : porte adresses, liens, réseaux. |
| **InterfacePhysique** | CQ2, CQ3, CQ17, CQ18 | Ports matériels. |
| **InterfaceLogique** | CQ17 | Sous-interfaces, loopback. |
| **Lien** | CQ3, CQ11, CQ18, CQ19 | Connexions physiques. |
| **LienLAN** | CQ3, CQ11 | Partition : LAN. |
| **LienWAN** | CQ11 | Partition : WAN (requiert Site pour contextualiser). |
| **SousReseau** | CQ7, CQ8, CQ9 | L3, CIDR. |
| **VLAN** | CQ4, CQ6 | L2 logique. |
| **Adresse** | CQ5, CQ7, CQ16 | Identifiants d'adressage. |
| **AdresseIPv4** | CQ16 | Distinction v4/v6. |
| **AdresseIPv6** | CQ16 | Distinction v4/v6. |
| **AdresseMAC** | CQ5 | L2. |
| **Service** | CQ12, CQ13 | L7. |
| **Protocole** | CQ13 | Services & protocoles applicatifs. |
| **Site** | CQ1, CQ11 | Contexte de localisation. |
| **Zone** | CQ14 | Segmentation documentaire. |
| **possedeInterface** | CQ2, CQ6, CQ10 | Relation d'appartenance. |
| **interfaceDe** | CQ2, CQ3 | Inverse. |
| **aExtremite** | CQ3, CQ11, CQ18 | Relie lien aux interfaces. |
| **connecteA** | CQ10 | Adjacence directe. |
| **porteePar** | CQ17 | Hiérarchie logique/physique. |
| **appartientAuReseau** | CQ4, CQ7, CQ8 | VLAN / sous-réseau. |
| **aAdresse** | CQ5, CQ7, CQ16 | Porte adresses. |
| **localiseA** | CQ1 | Site physique. |
| **heberge** | CQ1 | Inverse de localiseA. |
| **appartientAZone** | CQ14 | Zone. |
| **fournitService** | CQ12 | Services. |
| **utiliseProtocole** | CQ13 | Protocoles. |

---

## 10. Contrôle du périmètre

**Principe** : aucun concept hors du cadrage phase 0.

### Vérification contre les exclusions

| Exclusion | Vérification | Status |
|---|---|---|
| Métrologie / supervision temps réel | Aucune métrique, état live ou trafic en modèle. | ✅ Conforme |
| Configuration détaillée (ACL, tables de routage) | Ni ACL ni table de routage. Protocoles limités aux services (L7), pas de routage (OSPF/BGP). | ✅ Conforme |
| Historique / dimension temporelle | Pas de temporalité, pas de `dcterms:issued` sur instances. | ✅ Conforme |
| Virtualisation, cloud, overlays | Pas de VPC, VM, conteneurs, overlays. | ✅ Conforme |
| **Réseau sans fil** | ✅ `PointAccesSansFil`, `LienSansFil` retirés. Interface reste générique. | ✅ Conforme |
| Raisonnement sécurité | Zone purement documentaire, pas de DAC/RBAC/MAC. | ✅ Conforme |

**Conclusion** : ✅ Modèle conforme au périmètre.

---

## 11. Points laissés ouverts

À trancher en phase 3 ou phase 5 :

1. **Ambiguïté `numeroPort`** (cf. TODO.md) : actuellement domaine `InterfacePhysique`. 
   CQ13 réclame un port de transport (TCP/UDP). Créer `portTransport` sur `Service` ou `Protocole` en phase 3.

2. **Vérification des URI NML** (cf. TODO.md) : avant d'aligner en phase 3, vérifier existence et forme exactes de 
   `nml:BidirectionalPort` et `nml:BidirectionalLink` dans GFD.206.

3. **Cardinalité des liens** : un `Lien` est-il toujours point-à-point (exactement 2 extrémités) ou peut-il être multipoint ? 
   À décider lors de la formalisation OWL (phase 3).

4. **Disjointness : `Lien` vs `connecteA`** : une instance peut-elle à la fois être un `Lien` et une relation `connecteA` entre 
   deux interfaces ? À clarifier et potentiellement exprimer en contraintes SHACL (phase 5).

5. **`Protocole` ambiguïté** : le modèle accepte tout protocole (routage, service, liaison). Phase 3 doit clarifier : 
   limiter aux protocoles **de service** (HTTPS, DNS…), exclure explicitement OSPF/BGP.

---

## 12. Prochaines étapes

### Phase 3 — Formalisation OWL
- Traduire ce modèle en Turtle (`ontology/reseau-v0.ttl`).
- Appliquer les décisions du § 11.
- Valider au raisonneur (HermiT) : 0 classe incohérente.
- Écrire l'alignement NML (une fois URI confirmés).

### Phase 4 — Peuplement d'exemple
- Remplir `data/exemple-topologie.ttl` avec instances.
- Corriger l'instance `data/exemple-topologie.ttl:109` (`LienFilaire` → `LienLAN` ou `LienWAN`).

### Phase 5 — Évaluation & non-régression
- Une requête SPARQL par CQ (cf. matrice § 9).
- Contraintes SHACL : `typeSupport`, formats d'adresses, VLAN 1–4094.
- Vérifier « ports libres » (CQ18 — ports sans lien).

