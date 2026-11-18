#!/usr/bin/env bash
set -euo pipefail
[ -z "${1:-}" ] || [ ! -f "$1" ] && { echo "usage: $0 <hosts-file>"; exit 1; }

out="env_$(date +%Y%m%d_%H%M%S).txt"

httpx -l "$1" \
  -silent \
  -threads 50 \
  -timeout 10 \
  -retries 2 \
  -path '/.env' \
  -mc 200 \
  -ms 'APP_KEY=base64:' \
  -o "$out"

echo "[+] results: $out"
