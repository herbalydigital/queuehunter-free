#!/bin/sh
set -eu
cd "$(dirname "$0")"
sha256sum -c SHA256SUMS
project="${QH_PROJECT:-queuehunter-onprem}"
if ! docker inspect "$project-api-1" >/dev/null 2>&1; then
    exec sh "$PWD/setup.sh" "$@"
fi
files=$(docker inspect "$project-api-1" --format '{{index .Config.Labels "com.docker.compose.project.config_files"}}')
test -n "$files" || { echo 'An existing customer installation is required.' >&2; exit 1; }
api_image=$(docker inspect "$project-api-1" --format '{{.Config.Image}}')
web_image=$(docker inspect "$project-frontend-1" --format '{{.Config.Image}}')
printf 'services:
  api:
    image: %s
  frontend:
    image: %s
' "$api_image" "$web_image" > rollback.images.yaml
set -f
saved_ifs=$IFS
IFS=,
workdir=$(docker inspect "$project-api-1" --format '{{index .Config.Labels "com.docker.compose.project.working_dir"}}')
test -d "$workdir" || { echo 'Existing project directory is unavailable.' >&2; exit 1; }
set -- docker compose --project-directory "$workdir" -p "$project"
env_files=$(docker inspect "$project-api-1" --format '{{index .Config.Labels "com.docker.compose.project.environment_file"}}')
case "$env_files" in ''|'<no value>')
    if [ -f "$workdir/.env" ]; then set -- "$@" --env-file "$workdir/.env"; fi ;;
    *) for env_file in $env_files; do
        test -f "$env_file" || { echo 'Existing environment file is unavailable.' >&2; exit 1; }
        set -- "$@" --env-file "$env_file"
       done ;;
esac
for file in $files; do
    test -f "$file" || { echo 'Existing Compose configuration is unavailable.' >&2; exit 1; }
    set -- "$@" -f "$file"
done
IFS=$saved_ifs
set -- "$@" -f "$PWD/compose.release.yaml"
"$@" config --quiet
docker load -i images.tar
"$@" up -d --no-deps api frontend
