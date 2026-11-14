#!/bin/sh
set -eu
cd "$(dirname "$0")"
sha256sum -c SHA256SUMS
project="${QH_PROJECT:-queuehunter-onprem}"
if docker inspect "$project-api-1" >/dev/null 2>&1; then
    echo 'Existing installation: use install.sh for a preserving upgrade.' >&2
    exit 1
fi
if [ ! -e .env ]; then
    sample=env.example
    case "${1:-default}" in
        default) ;;
        *) echo 'This package has no sign-in profiles; run ./install.sh without arguments.' >&2; exit 2 ;;
    esac
    test -f "$sample"
    (umask 077; cp "$sample" .env; chmod 600 .env)
    echo 'Created private .env. Set LICENSE_KEY and your broker settings, then run install.sh again.'
    exit 0
fi
if ! grep -Eq '^[[:space:]]*LICENSE_KEY=[^[:space:]#]+' .env; then
    echo 'Set LICENSE_KEY in your private .env before starting.' >&2
    exit 1
fi
docker compose -p "$project" -f compose.prebuilt.yaml config --quiet
docker load -i images.tar
docker compose -p "$project" -f compose.prebuilt.yaml up -d
