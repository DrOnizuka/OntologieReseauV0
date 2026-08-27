# Consignes de construction — Ontologie Réseau Informatique

Ce document fixe les **règles à suivre** pour construire et faire évoluer
l'ontologie. Il a deux usages :

- **Partie 1 — Résumé** : lecture rapide pour l'équipe (l'essentiel en une page).
- **Partie 2 — Référence détaillée** : version explicite, destinée à servir de
  référence à des agents (IA) comme à toute personne appliquant les consignes.

Documents liés : `CONTRIBUTING.md` (workflow Git, nommage), `docs/modele.md`
(modèle courant et décisions ouvertes).

---

# Partie 1 — Résumé (pour l'équipe)

## Les 3 règles cardinales

1. **Plafond de taille : 50 concepts maximum** (classes + *ObjectProperties*
   confondues). Contrainte forte de simplicité : si on doit dépasser, on
   arbitre en équipe et on justifie.
2. **Périmètre strict = réseau informatique.** Le contexte précis reste **à
   définir finement** (voir Partie 2 §1). On ne crée **aucun** concept hors de
   ce périmètre — même « au cas où ».
3. **Phase préalable obligatoire avant de modéliser** : on répond d'abord aux
   4 questions ci-dessous. Pas de classe/propriété tant que ce n'est pas fait.

## Les 4 questions à traiter AVANT de créer l'ontologie

| # | Question | Livrable attendu |
|---|----------|------------------|
| Q1 | **Ontologies / représentations existantes** sur le sujet ? Lesquelles reprendre ? | Une liste des sources, avec pour chacune : *reprise* ou *écartée* **+ la raison** (on garde la trace même des sources non retenues). |
| Q2 | **Utilisateur cible** ? Qui l'utilise, quelles compétences ? | Profil(s) d'utilisateur → détermine la complexité admissible et le mode d'interaction. |
| Q3 | **Comment vérifier la cohérence** de la production ? | Critères : couverture, réutilisation de l'existant, pertinence des définitions, cohérence logique. |
| Q4 | **Comment vérifier la non-régression** ? | Jeu de requêtes SPARQL / contraintes SHACL rejouables à chaque évolution. |

## En bref, le flux de travail

```
Définir le contexte  →  Répondre Q1–Q4  →  Modéliser (≤ 50 concepts)
      →  Instancier un exemple  →  Vérifier cohérence (Q3) + non-régression (Q4)
      →  Documenter  →  PR + relecture
```

> État actuel : le socle V0 compte **37 concepts** (26 classes + 11 ObjectProperties),
> il reste donc de la marge sous le plafond de 50.

---

# Partie 2 — Référence détaillée (pour les agents et l'application stricte)

Cette partie explicite chaque règle, les critères d'acceptation et les
livrables. Un agent qui produit ou modifie l'ontologie **doit** s'y conformer et
pouvoir justifier chaque décision au regard de ces consignes.

## 1. Périmètre : réseau informatique (contexte à préciser)

**Règle.** L'ontologie porte exclusivement sur le **réseau informatique**. Tout
concept doit appartenir à ce périmètre ; un concept hors périmètre est refusé,
même s'il « pourrait servir plus tard ».

**Contexte à définir finement (préalable).** « Réseau informatique » est encore
trop large. Avant de figer le modèle, l'équipe doit trancher le cadrage, p. ex. :

- **Niveau(x) couvert(s)** : physique (câblage, ports), liaison (VLAN, MAC),
  réseau (IP, routage), services applicatifs ? Jusqu'où va-t-on ?
- **Échelle** : LAN d'entreprise, datacenter, WAN/opérateur, cloud ?
- **Finalité** : documentation/CMDB, supervision, sécurité, conception ?
- **Ce qui est explicitement exclu** (à écrire noir sur blanc).

Le cadrage retenu est consigné dans `docs/modele.md` (périmètre) et sert de
juge de paix pour accepter ou refuser un concept.

**Critère d'acceptation d'un concept.** Il est dans le périmètre ET justifié par
au moins une question de compétence (voir §5).

## 2. Plafond de 50 concepts

**Règle.** Le total `classes + ObjectProperties` ne dépasse jamais **50**.
(Les *DatatypeProperties* — simples attributs — ne sont pas comptées dans ce
plafond, mais restent soumises à la sobriété.)

**Comment compter.** Nombre de `owl:Class` déclarées + nombre de
`owl:ObjectProperty` déclarées dans `ontology/`. Vérification possible :

```bash
python3 - <<'PY'
import rdflib
from rdflib import RDF, OWL
g = rdflib.Graph(); g.parse("ontology/reseau-v0.ttl", format="turtle")
cls = set(g.subjects(RDF.type, OWL.Class))
op  = set(g.subjects(RDF.type, OWL.ObjectProperty))
print("classes:", len(cls), "| object properties:", len(op),
      "| total:", len(cls)+len(op), "/ 50")
PY
```

**Conséquence.** Chaque ajout est un arbitrage : si on approche de 50, préférer
**généraliser** (fusionner des classes proches, remplacer des sous-classes par
une propriété) plutôt qu'accumuler. Tout franchissement du plafond exige une
décision d'équipe tracée dans le `CHANGELOG.md`.

## 3. Phase préalable : répondre aux 4 questions

Ces questions sont un **prérequis bloquant**. Leurs réponses sont documentées
(idéalement dans `docs/`) et mises à jour si le contexte évolue. La liste
n'est **pas exhaustive** : l'équipe peut en ajouter.

### Q1 — Ontologies / représentations existantes
- **But** : ne pas réinventer, réutiliser ce qui est mûr et interopérable.
- **Action** : recenser les ontologies, vocabulaires, schémas ou tout autre
  format de représentation structurée de la connaissance portant sur le réseau
  informatique.
- **Livrable** : un tableau des sources examinées avec, pour chacune :
  identité/URL, ce qu'elle couvre, **décision = reprise / partiellement reprise /
  écartée**, et **la justification**. Les sources **non retenues sont conservées**
  dans la trace (savoir *pourquoi* on ne les a pas prises a de la valeur).
- **Critère** : aucune création d'un concept déjà fourni par une source qu'on a
  décidé de reprendre.

### Q2 — Utilisateur cible
- **But** : calibrer la complexité et le mode d'interaction sur le public réel.
- **Action** : identifier qui utilisera l'ontologie (ex. ingénieur réseau,
  développeur d'appli, agent IA, décideur) et **quelles sont ses compétences**
  (maîtrise du web sémantique ? SPARQL ? simple lecture ?).
- **Impact** : un public non-expert impose une ontologie plus simple, des
  libellés clairs, et probablement une couche d'accès (requêtes prêtes,
  interface) plutôt qu'un usage direct d'OWL.
- **Livrable** : description des profils cibles et du mode d'interaction attendu.

### Q3 — Vérification de la cohérence de la production
- **But** : garantir la qualité intrinsèque de l'ontologie.
- **Dimensions à vérifier** :
  - **Couverture** : l'ontologie répond-elle aux questions de compétence (§5) et
    au périmètre défini ? Ni trous, ni hors-sujet.
  - **Réutilisation** : les vocabulaires/ontologies retenus en Q1 sont-ils
    effectivement mobilisés plutôt que redéfinis ?
  - **Pertinence des définitions** : chaque classe/propriété a un `rdfs:label`@fr
    et une définition (`rdfs:comment`) claire, non ambiguë, non circulaire.
  - **Cohérence logique** : le raisonneur (HermiT/Pellet dans Protégé) déclare
    l'ontologie *consistent* et **aucune classe** n'est incohérente
    (équivalente à `owl:Nothing`).
- **Livrable** : une checklist de revue cochée à chaque PR.

### Q4 — Vérification de la non-régression
- **But** : s'assurer qu'une évolution ne casse pas ce qui marchait.
- **Action** : maintenir un jeu de tests **rejouables** :
  - **requêtes SPARQL** de `queries/` associées à un résultat attendu ;
  - **contraintes SHACL** validant la forme des données (formats d'adresses,
    VLAN 1–4094, cardinalités attendues, etc.) ;
  - éventuellement des tests de raisonnement (inférences attendues).
- **Règle** : avant fusion, on rejoue ces tests ; toute divergence est traitée
  ou explicitement justifiée. Toute nouvelle capacité s'accompagne d'un
  nouveau test.
- **Livrable** : tests versionnés dans le dépôt (`queries/`, futur `shapes/`).

## 4. Principes de modélisation (rappel opérationnel)

- **Classe** = type ; **individu** = instance (va dans `data/`, jamais dans
  `ontology/`).
- Une **ObjectProperty** relie deux entités ; une **DatatypeProperty** porte une
  valeur littérale typée XSD. Ne pas les confondre.
- Renseigner **toujours** `rdfs:domain` et `rdfs:range`.
- Déclarer les caractéristiques (`Functional`, `Symmetric`, `inverseOf`)
  uniquement si elles sont **toujours vraies** dans le domaine.
- **Généraliser plutôt que multiplier** : préférer une propriété à une
  prolifération de sous-classes (cohérent avec le plafond de 50).
- Réutiliser `rdfs`, `skos`, `dcterms` ; ne pas redéfinir l'existant.

## 5. Questions de compétence (Competency Questions)

Le modèle est **piloté par des questions de compétence** : toute classe/propriété
doit être justifiée par au moins une question à laquelle l'ontologie doit savoir
répondre. Exemples (à enrichir) : équipements d'un site, interfaces d'un VLAN,
adjacences d'un équipement, adresses IP d'un sous-réseau, services d'un serveur.
Chaque question devrait avoir une requête SPARQL correspondante (lien avec Q4).

## 6. Anti-patterns interdits

- ❌ Concept hors périmètre réseau informatique.
- ❌ Dépassement du plafond de 50 sans décision tracée.
- ❌ Modéliser « au cas où », sans question de compétence.
- ❌ Individus dans le fichier de schéma.
- ❌ Redéfinir un concept déjà fourni par une source reprise (Q1).
- ❌ Propriété sans domaine/portée ; définition absente ou circulaire.
- ❌ Contraintes trop fortes qui rendent des données valides « incohérentes ».

## 7. Définition de « terminé » pour une contribution

Une évolution est acceptable en PR si **tout** est vrai :

- [ ] Elle reste dans le périmètre réseau informatique défini.
- [ ] Le total classes + ObjectProperties est **≤ 50**.
- [ ] Les questions Q1–Q4 pertinentes sont à jour.
- [ ] Chaque nouvelle entité a `rdfs:label`@fr + définition claire.
- [ ] Le raisonneur ne signale aucune incohérence (Q3).
- [ ] Les tests SPARQL/SHACL de non-régression passent (Q4).
- [ ] `docs/modele.md` et `CHANGELOG.md` sont à jour.
