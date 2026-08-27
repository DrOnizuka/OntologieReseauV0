#!/bin/sh
# Credential helper git qui lit les identifiants depuis le .env du dépôt.
#
# But : permettre le push HTTPS sans jamais exposer le token —
#   - git APPELLE ce script et LIT sa sortie standard (qu'il consomme en interne) ;
#   - la valeur du token n'apparaît donc dans aucune commande, aucun argument,
#     aucun log, aucune URL.
#
# Le script lui-même ne contient AUCUN secret : il lit .env à l'exécution.
# .env reste ignoré par git (voir .gitignore).
#
# Usage (configuré par le skill git-push-secure, pas en dur) :
#   git -c credential.helper="$(git rev-parse --show-toplevel)/.claude/skills/git-push-secure/git-credential-env.sh" push

# git appelle le helper avec un verbe : get | store | erase.
# On ne répond qu'à "get" (fourniture des identifiants).
[ "$1" = "get" ] || exit 0

ENV_FILE="$(git rev-parse --show-toplevel 2>/dev/null)/.env"
[ -f "$ENV_FILE" ] || exit 0

# Charger GIT_USERNAME / GIT_PASSWORD depuis .env.
. "$ENV_FILE"

# Fournir les identifiants à git sur stdout (consommé par git, non affiché).
[ -n "$GIT_USERNAME" ] && printf 'username=%s\n' "$GIT_USERNAME"
[ -n "$GIT_PASSWORD" ] && printf 'password=%s\n' "$GIT_PASSWORD"
exit 0
