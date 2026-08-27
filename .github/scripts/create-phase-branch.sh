#!/bin/bash

# Script d'aide : créer une branche pour une phase spécifique et préparer une PR
# Usage: ./create-phase-branch.sh <phase> [branch_name]
# Exemple: ./create-phase-branch.sh 3-formalisation OWL

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$( cd "$SCRIPT_DIR/../../" && pwd )"

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Paramètres
PHASE="${1:-}"
BRANCH_NAME="${2:-}"

# Aide
if [ -z "$PHASE" ]; then
  echo -e "${BLUE}📚 Créer une branche pour une phase de travail${NC}"
  echo ""
  echo "Usage: $0 <phase> [branch_name]"
  echo ""
  echo "Phases disponibles :"
  echo "  2-conceptualisation"
  echo "  3-formalisation"
  echo "  4-peuplement"
  echo "  5-evaluation"
  echo ""
  echo "Exemples :"
  echo "  $0 3-formalisation OWL"
  echo "  $0 4-peuplement peuplement"
  exit 1
fi

# Déterminer le nom de branche par défaut si non fourni
if [ -z "$BRANCH_NAME" ]; then
  case "$PHASE" in
    2-conceptualisation) BRANCH_NAME="conceptualisation" ;;
    3-formalisation) BRANCH_NAME="OWL" ;;
    4-peuplement) BRANCH_NAME="peuplement" ;;
    5-evaluation) BRANCH_NAME="evaluation" ;;
    *) BRANCH_NAME="phase-$PHASE" ;;
  esac
fi

echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo -e "${GREEN}✨ Préparation branche ${BLUE}$BRANCH_NAME${GREEN} (phase ${BLUE}$PHASE${GREEN})${NC}"
echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo ""

# Vérifier que nous sommes dans un repo git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo -e "${RED}❌ Erreur : pas un dépôt git${NC}"
  exit 1
fi

cd "$REPO_ROOT"

# Vérifier que la branche main existe et est à jour
echo -e "${YELLOW}📌 Synchronisation avec origin/main...${NC}"
git fetch origin main

# Créer la branche
echo -e "${YELLOW}📌 Création branche ${BLUE}$BRANCH_NAME${YELLOW}...${NC}"
if git show-ref --quiet refs/heads/$BRANCH_NAME; then
  echo -e "${YELLOW}⚠️  Branche $BRANCH_NAME existe déjà. Basculement...${NC}"
  git checkout $BRANCH_NAME
  git rebase origin/main
else
  git checkout -b $BRANCH_NAME origin/main
fi

echo ""

# Afficher les informations de phase
case "$PHASE" in
  2-conceptualisation)
    echo -e "${BLUE}📋 Phase 2 — Conceptualisation${NC}"
    echo "Tâches :"
    echo "  □ Glossaire (termes métier)"
    echo "  □ Hiérarchie des classes"
    echo "  □ Relations (ObjectProperties)"
    echo "  □ Attributs (DatatypeProperties)"
    echo "  □ Schéma Mermaid"
    echo "  □ Matrice traçabilité CQ"
    echo "  □ Contrôle plafond (≤ 50)"
    echo "  □ Vérification périmètre"
    echo ""
    echo "Fichiers à modifier :"
    echo "  - docs/modele.md"
    echo "  - docs/feuille-de-route.md"
    echo "  - docs/phases/phase-2-conceptualisation.md"
    echo "  - TODO.md"
    ;;
  3-formalisation)
    echo -e "${BLUE}📋 Phase 3 — Formalisation OWL${NC}"
    echo "Tâches :"
    echo "  □ Classes OWL (25)"
    echo "  □ ObjectProperties (12)"
    echo "  □ DatatypeProperties (12)"
    echo "  □ Métadonnées DCMI Terms"
    echo "  □ Alignements NML"
    echo "  □ Vérifier syntaxe Turtle"
    echo "  □ Valider au raisonneur (HermiT)"
    echo ""
    echo "Fichiers à modifier :"
    echo "  - ontology/reseau-v0.ttl"
    echo "  - docs/phases/phase-3-formalisation.md"
    echo "  - TODO.md"
    ;;
  4-peuplement)
    echo -e "${BLUE}📋 Phase 4 — Peuplement d'exemple${NC}"
    echo "Tâches :"
    echo "  □ Instances d'exemple"
    echo "  □ Topologies réseau"
    echo "  □ Exemples par CQ"
    echo "  □ Vérifier donnéees valident"
    echo ""
    echo "Fichiers à modifier :"
    echo "  - data/exemple-topologie.ttl"
    echo "  - docs/phases/phase-4-peuplement.md"
    echo "  - TODO.md"
    ;;
  5-evaluation)
    echo -e "${BLUE}📋 Phase 5 — Évaluation et non-régression${NC}"
    echo "Tâches :"
    echo "  □ Requêtes SPARQL (19 CQ)"
    echo "  □ Contraintes SHACL"
    echo "  □ Tester non-régression"
    echo ""
    echo "Fichiers à modifier :"
    echo "  - queries/*.rq"
    echo "  - shapes/*.ttl"
    echo "  - docs/phases/phase-5-evaluation.md"
    echo "  - TODO.md"
    ;;
esac

echo ""
echo -e "${YELLOW}📝 Prochaines étapes :${NC}"
echo "  1. Faire vos modifications"
echo "  2. Tester localement (voir CI-CD.md)"
echo "  3. Committer : git commit -m 'feat(${BRANCH_NAME}): Description'"
echo "  4. Pousser : git push -u origin $BRANCH_NAME"
echo "  5. Créer PR sur GitHub"
echo ""
echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Branche ${BLUE}$BRANCH_NAME${GREEN} prête !${NC}"
echo -e "${BLUE}═══════════════════════════════════════${NC}"
