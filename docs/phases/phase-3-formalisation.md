# Phase 3 — Formalisation OWL (Turtle)

> Retour à la [feuille de route](../feuille-de-route.md) · Consignes : [consignes-construction.md](../consignes-construction.md)

**Statut : ⬜ À faire**

## Objectif

Traduire le modèle conceptuel validé en **ontologie OWL 2 sérialisée en Turtle**
dans `ontology/`, avec définitions, hiérarchie, domaines/portées et axiomes.

## Entrées

- Modèle conceptuel validé ([phase 2](phase-2-conceptualisation.md)).

## Tâches

- [ ] En-tête d'ontologie : IRI, `owl:versionIRI`, `owl:versionInfo`, métadonnées Dublin Core.
- [ ] Déclarer les **classes** + hiérarchie `rdfs:subClassOf`.
- [ ] Déclarer les **ObjectProperties** avec `rdfs:domain` / `rdfs:range`.
- [ ] Déclarer les **DatatypeProperties** avec types XSD.
- [ ] Caractéristiques (`Functional`, `Symmetric`, `inverseOf`) **si toujours vraies**.
- [ ] **Disjonctions** (`owl:disjointWith` / `AllDisjointClasses`) pertinentes.
- [ ] `rdfs:label`@fr + `rdfs:comment`@fr sur **chaque** entité.
- [ ] Réutiliser les vocabulaires retenus en phase 1 (pas de redéfinition).

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
