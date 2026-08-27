# Phase 0 — Cadrage & spécification (ORSD)

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : ✅ Validé** (jalon atteint le 2026-08-27 — périmètre, utilisateurs et CQ arrêtés)

## Objectif

Produire le **document de spécification des besoins** (ORSD, *Ontology
Requirements Specification Document* — NeOn) : cadrer finement le périmètre,
identifier l'utilisateur cible (**Q2**) et fixer les questions de compétence.
C'est le socle qui autorise (ou refuse) chaque concept par la suite.

## Entrées

- `docs/consignes-construction.md`
- Brouillon exploratoire `ontology/reseau-v0.ttl` (comme matière de départ)

## Tâches

- [x] **Finalité de l'ontologie** : à quoi doit-elle servir (documentation/CMDB, supervision, sécurité, conception… ) ?
- [x] **Périmètre fin « réseau informatique »** :
  - [x] Niveau(x) couvert(s) : physique / liaison (L2) / réseau (L3) / services ?
  - [x] Échelle : LAN, datacenter, WAN, cloud ?
  - [x] **Exclusions explicites** (ce qu'on ne modélise PAS).
- [x] **Q2 — Utilisateur cible** : profils, compétences (web sémantique ? SPARQL ? lecture seule ?), mode d'interaction attendu.
- [x] **Questions de compétence (CQ)** : lister les questions auxquelles l'ontologie devra répondre (viser un jeu représentatif).
- [x] **Rappel des contraintes** : plafond ≤ 50 concepts, périmètre strict.

## Livrables

- Section **Périmètre & exclusions** ci-dessous (reprise dans `docs/modele.md` en phase 2).
- Liste des **profils utilisateurs** ci-dessous.
- Jeu de **19 CQ validées**, réutilisable en phase 5 pour les requêtes de non-régression.

## Décisions de cadrage (2026-08-27)

### Finalité
- **Documentation / CMDB** : décrire et inventorier le réseau. (Finalité unique retenue pour la V0.)

### Périmètre — DANS le champ
| Aspect | Retenu |
|--------|--------|
| Niveaux | **L1 physique** (câblage, ports, sites) · **L2 liaison** (VLAN, MAC, commutation) · **L3 réseau** (IP, sous-réseaux, routeurs) · **L7 services applicatifs** (DNS, DHCP, web...) |
| Routage | **Connectivité uniquement** — pas de protocoles de routage (OSPF/BGP), pas de tables de routes |
| Segmentation | **Zones** conservées comme attribut de segmentation **documentaire** (DMZ, LAN, WAN) — sans raisonnement sécurité |
| Échelle | **LAN d'entreprise** + **WAN / opérateur** (interconnexion de sites) |
| Support | **Filaire uniquement** |

### Périmètre — HORS champ (exclusions explicites)
- **Métrologie / supervision** temps réel (métriques, état live, trafic)
- **Configuration détaillée** (ACL, tables de routage)
- **Historique / dimension temporelle**
- **Réseaux / machines virtuels** (virtualisation, VPC, overlays) et cloud
- Réseau **sans fil** (Wi-Fi, points d'accès, liens radio)
- **Protocoles de routage** (OSPF, BGP...) et raisonnement de sécurité

> **Portée d'une exclusion.** Exclure n'est pas nier : l'ontologie ne dira jamais
> « ce lien n'est pas radio », elle ne parlera simplement pas de radio. Aucune
> classe ne sert à marquer l'absence d'un élément hors périmètre. Réintroduire
> un sujet exclu = réouverture de périmètre, donc boucle phases 2 → 5.

### Utilisateurs cibles (Q2)
- **Agents IA / applications** → consommation programmatique (SPARQL, raisonnement) : exige rigueur et cohérence.
- **Ingénieurs réseau** (experts métier) → lecture directe possible ; libellés métier clairs.
- **Non-experts / décideurs** → lecture seule ; nécessitera probablement une couche d'accès simplifiée (hors ontologie elle-même).
- *Conséquence* : complexité modérée, libellés `@fr` explicites obligatoires, cohérence logique stricte.

## Questions de compétence (CQ) — **validées**

19 CQ arrêtées. Toute classe ou propriété créée en phases 2–3 devra se
rattacher à au moins l'une d'entre elles ; réciproquement, chaque CQ devra
avoir sa requête SPARQL en phase 5. La numérotation est **stable** : les CQ
ajoutées lors de la validation portent les numéros 16 à 19 plutôt que de
renuméroter les précédentes.

### L1 — Physique / localisation
- **CQ1** — Quels équipements sont hébergés sur un site donné ?
- **CQ2** — Quels sont les ports physiques d'un équipement et leur débit ?
- **CQ3** — Quel lien physique relie deux équipements (et par quelles interfaces) ?
- **CQ18** — Quels ports physiques d'un équipement ne sont raccordés à aucun lien (ports libres) ?
- **CQ19** — Quel est le support physique d'un lien (cuivre, fibre monomode, fibre multimode) ?

### L2 — Liaison
- **CQ4** — Quelles interfaces appartiennent à un VLAN donné ?
- **CQ5** — Quelle est l'adresse MAC d'une interface ?
- **CQ6** — Quels équipements partagent un même VLAN ? *(CQ **dérivée** : chaînage CQ4 + `interfaceDe`. Conservée car elle teste le chaînage de propriétés en phase 5, ce que CQ4 seule ne fait pas.)*

### L3 — Réseau
- **CQ7** — Quelles adresses IP sont utilisées dans un sous-réseau donné ?
- **CQ8** — À quel sous-réseau (adresse/masque) appartient une interface ?
- **CQ9** — Quels routeurs interconnectent quels sous-réseaux ?
- **CQ16** — Quels équipements / interfaces sont adressés en IPv6 (vs IPv4) ?
- **CQ17** — Quelles interfaces logiques sont portées par une interface physique donnée ?

### Topologie / connectivité
- **CQ10** — Quels équipements sont directement adjacents à un équipement donné ?
- **CQ11** — Quels liens WAN relient deux sites ?

### L7 — Services
- **CQ12** — Quels services sont fournis par un serveur donné ?
- **CQ13** — Quel protocole et quel port de transport sont associés à un service donné ?

### Segmentation / inventaire
- **CQ14** — Quels équipements appartiennent à une zone donnée (ex. DMZ) ?
- **CQ15** — Lister les équipements par **type**, fabricant, modèle, version logicielle.

### Précisions attachées aux CQ

- **CQ7 — appartenance assertée, non calculée.** Le rattachement d'une adresse à
  un sous-réseau se lit par le chemin `Interface appartientAuReseau SousReseau`
  + `Interface aAdresse AdresseIP`. Il n'est **pas** calculé depuis
  `adresseReseau`/`prefixeCIDR` : l'arithmétique CIDR n'est ni dans OWL ni
  raisonnablement exprimable en SPARQL. À respecter en phase 5.
- **CQ13 — ambiguïté `numeroPort`.** Le brouillon utilise déjà `numeroPort` pour
  le **port physique** (domaine `InterfacePhysique`). CQ13 parle du **port de
  transport** (TCP/UDP) d'un service : il faudra deux propriétés distinctes,
  nommées sans ambiguïté, en phase 3.
- **CQ15 — élargie au type d'équipement**, ce qui justifie d'un seul coup
  `Routeur`, `Commutateur`, `PareFeu`, `Serveur`, `Terminal` (seul `Routeur`
  était couvert, par CQ9).

## Décisions de modélisation induites (à appliquer en phases 2–3–4)

Conséquences directes du périmètre et des CQ validées, sur le brouillon
`ontology/reseau-v0.ttl` :

| Décision | Motif | Δ concepts |
|----------|-------|-----------|
| **Retirer** `PointAccesSansFil` | Sans-fil hors périmètre | −1 |
| **Retirer** `LienSansFil` | Sans-fil hors périmètre | −1 |
| **Retirer** `LienFilaire` | Sans le sans-fil, la classe a une extension universelle : elle ne partitionne plus rien | −1 |
| **Ajouter** `LienLAN` et `LienWAN` (partition disjointe de `Lien`) | Porte CQ11 ; remplace la partition filaire/sans-fil devenue vide de sens par la seule partition utile au périmètre | +2 |
| **Ajouter** `porteePar` (`InterfaceLogique` → `InterfacePhysique`) | Porte CQ17 et justifie le maintien de la distinction physique/logique | +1 |
| **Conserver** `AdresseIPv4` / `AdresseIPv6` | Justifiées par CQ16 | 0 |
| **Conserver** `Service` et `fournitService` | L7 dans le périmètre (CQ12) | 0 |
| **Conserver** `Zone`, requalifiée en segmentation **documentaire** | CQ14, sans sémantique sécurité | 0 |
| **Réinterroger** `Protocole` | Garder pour typer les services (DNS, HTTPS — CQ13), jamais pour les protocoles de routage | 0 |
| **Ajouter** `typeSupport` (DatatypeProperty sur `Lien`) + vocabulaire fermé en SHACL | Porte CQ19. Choisi en propriété et non en sous-classes : `Lien` porte déjà la partition LAN/WAN, une seconde partition orthogonale (cuivre/fibre) provoquerait une explosion combinatoire | 0 *(les DatatypeProperties ne comptent pas)* |

**Budget résultant : 37 − 3 + 2 + 1 = 37 / 50**, soit 13 places de marge pour la
conceptualisation. Règle retenue au passage : **un seul axe de partition en
sous-classes par classe**, les autres axes passent en propriétés.

### Points laissés ouverts pour la phase 2
- `actif` (DatatypeProperty) n'est couvert par **aucune CQ** — la CQ « éléments
  hors service » a été écartée à la validation. À retirer ou à justifier en phase 2.
- `data/exemple-topologie.ttl:109` instancie `res:LienFilaire` : à retyper en
  `LienLAN` ou `LienWAN` en phase 4.

## Jalon de validation

📌 **Spécification validée** ✅ — périmètre écrit noir sur blanc, profils
utilisateurs identifiés, jeu de 19 CQ arrêté. La phase 1 peut s'ouvrir.

## Sortie → phase suivante

Le périmètre et les CQ conditionnent l'[étude de l'existant](phase-1-existant.md).
