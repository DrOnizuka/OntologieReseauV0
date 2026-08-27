# Phase 3 — Formalisation OWL (Turtle)

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : 🟡 En cours** (Turtle écrit, syntaxe vérifiée, plafond validé — en attente raisonneur)

## Objectif

Traduire le modèle conceptuel validé en **ontologie OWL 2 sérialisée en Turtle**
dans `ontology/`, avec définitions, hiérarchie, domaines/portées et axiomes.

## Entrées

- Modèle conceptuel validé ([phase 2](phase-2-conceptualisation.md)).

## Tâches

- [x] En-tête d'ontologie : IRI, `owl:versionIRI`, `owl:versionInfo`, métadonnées Dublin Core ✅
- [x] Déclarer les **classes** + hiérarchie `rdfs:subClassOf` (25 classes) ✅
- [x] Déclarer les **ObjectProperties** avec `rdfs:domain` / `rdfs:range` (12 ObjectProperties) ✅
- [x] Déclarer les **DatatypeProperties** avec types XSD (12 DatatypeProperties) ✅
- [x] Caractéristiques (`Functional`, `Symmetric`, `inverseOf`) **si toujours vraies** ✅
- [x] **Disjonctions** (`owl:disjointWith` / `AllDisjointClasses`) pertinentes ✅
- [x] `rdfs:label`@fr + `rdfs:comment`@fr sur **chaque** entité ✅
- [x] Réutiliser les vocabulaires retenus en phase 1 (alignement NML, DCMI Terms) ✅
- [ ] **Vérifier alignement NML** : confirmer URIs dans GFD.206, valider au raisonneur → *en attente*
- [ ] **Valider au raisonneur** (HermiT dans Protégé) : 0 classe incohérente → *en attente*

## Vérifications

```bash
# Syntaxe
python3 -c "import rdflib,sys;[rdflib.Graph().parse(f) for f in sys.argv[1:]]" ontology/*.ttl
# Plafond
python3 - <<'PY'
import rdflib; from rdflib import RDF, OWL
g=rdflib.Graph(); g.parse("ontology/reseau-v0.ttl")
c=len(set(g.subjects(RDF.type,OWL.Class))); o=len(set(g.subjects(RDF.type,OWL.ObjectProperty)))
print(f"{c}+{o}={c+o}/50")
PY
```
Puis dans **Protégé** : lancer HermiT/Pellet.

## Livrable

- `ontology/reseau-v0.ttl` conforme au modèle validé.

## Jalon de validation

📌 Le `.ttl` **parse sans erreur**, le **plafond ≤ 50** est respecté, et le
**raisonneur** déclare l'ontologie *consistent* avec **0 classe incohérente**.

## Sortie → phase suivante

L'ontologie sert de schéma au [peuplement d'exemple](phase-4-peuplement.md).
