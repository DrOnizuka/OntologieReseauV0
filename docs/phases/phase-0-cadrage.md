# Phase 0 — Cadrage & spécification (ORSD)

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : 🟡 En cours** (cadrage en cours de validation — 2026-08-27)

## Objectif

Produire le **document de spécification des besoins** (ORSD, *Ontology
Requirements Specification Document* — NeOn) : cadrer finement le périmètre,
identifier l'utilisateur cible (**Q2**) et fixer les questions de compétence.
C'est le socle qui autorise (ou refuse) chaque concept par la suite.

## Entrées

- `docs/consignes-construction.md`
- Brouillon exploratoire `ontology/reseau-v0.ttl` (comme matière de départ)

## Tâches

- [ ] **Finalité de l'ontologie** : à quoi doit-elle servir (documentation/CMDB, supervision, sécurité, conception… ) ?
- [ ] **Périmètre fin « réseau informatique »** :
  - [ ] Niveau(x) couvert(s) : physique / liaison (L2) / réseau (L3) / services ?
  - [ ] Échelle : LAN, datacenter, WAN, cloud ?
  - [ ] **Exclusions explicites** (ce qu'on ne modélise PAS).
- [ ] **Q2 — Utilisateur cible** : profils, compétences (web sémantique ? SPARQL ? lecture seule ?), mode d'interaction attendu.
- [ ] **Questions de compétence (CQ)** : lister les questions auxquelles l'ontologie devra répondre (viser un jeu représentatif).
- [ ] **Rappel des contraintes** : plafond ≤ 50 concepts, périmètre strict.

## Livrables

- Section **Périmètre & exclusions** dans `docs/modele.md` (ou ORSD dédié).
- Liste des **profils utilisateurs**.
- Liste initiale des **CQ** (réutilisable en phase 5 pour les requêtes).

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

### Utilisateurs cibles (Q2)
- **Agents IA / applications** → consommation programmatique (SPARQL, raisonnement) : exige rigueur et cohérence.
- **Ingénieurs réseau** (experts métier) → lecture directe possible ; libellés métier clairs.
- **Non-experts / décideurs** → lecture seule ; nécessitera probablement une couche d'accès simplifiée (hors ontologie elle-même).
- *Conséquence* : complexité modérée, libellés `@fr` explicites obligatoires, cohérence logique stricte.

### Impacts sur le brouillon `reseau-v0.ttl` (à traiter en phase 2)
- **Conserver** `Service` et `fournitService` (L7 dans le périmètre).
- **Conserver** `Zone` mais requalifier en segmentation documentaire (pas de sémantique sécurité).
- **Retirer** `PointAccesSansFil` et `LienSansFil` (sans-fil hors champ).
- **Réinterroger** `Protocole` : garder pour typer les services (ex. DNS, HTTPS), mais pas les protocoles de routage.

### Questions de compétence (CQ) — brouillon à valider

**L1 — Physique / localisation**
- CQ1 — Quels équipements sont hébergés sur un site donné ?
- CQ2 — Quels sont les ports physiques d'un équipement et leur débit ?
- CQ3 — Quel lien physique relie deux équipements (et par quelles interfaces) ?

**L2 — Liaison**
- CQ4 — Quelles interfaces appartiennent à un VLAN donné ?
- CQ5 — Quelle est l'adresse MAC d'une interface ?
- CQ6 — Quels équipements partagent un même VLAN ?

**L3 — Réseau**
- CQ7 — Quelles adresses IP sont utilisées dans un sous-réseau donné ?
- CQ8 — À quel sous-réseau (adresse/masque) appartient une interface ?
- CQ9 — Quels routeurs interconnectent quels sous-réseaux ?

**Topologie / connectivité**
- CQ10 — Quels équipements sont directement adjacents à un équipement donné ?
- CQ11 — Quels liens WAN relient deux sites ?

**L7 — Services**
- CQ12 — Quels services sont fournis par un serveur donné ?
- CQ13 — Quel protocole/port est associé à un service donné ?

**Segmentation / inventaire**
- CQ14 — Quels équipements appartiennent à une zone donnée (ex. DMZ) ?
- CQ15 — Lister les équipements par fabricant / modèle / version logicielle.

> Statut : **brouillon** — à valider/amender avant clôture de la phase 0.

## Jalon de validation

📌 **Spécification validée en équipe** : périmètre écrit noir sur blanc,
profils utilisateurs identifiés, jeu de CQ arrêté. Sans ce jalon, la phase 1
ne s'ouvre pas.

## Sortie → phase suivante

Le périmètre et les CQ conditionnent l'[étude de l'existant](phase-1-existant.md).
