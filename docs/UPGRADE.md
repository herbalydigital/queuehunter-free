# Upgrade and rollback

New versions are published as [releases](https://github.com/herbalydigital/queuehunter-free/releases). Read the release notes and the
[changelog](../CHANGELOG.md) first.

## Upgrade

1. Back up the installation ([backup guide](BACKUP-AND-RESTORE.md)).
2. Download the new package and its `.sha256`, verify it and extract it into a **new** directory,
   for example `/opt/queuehunter-0.1.20`.
3. Run the installer from the new directory:
   ```sh
   cd /opt/queuehunter-0.1.20
   sha256sum -c SHA256SUMS
   ./install.sh
   ```
   It finds the running `queuehunter-onprem` project, reuses its Compose files and `.env`
   exactly where they are, loads the new images and replaces only the `api` and `frontend`
   images. Your configuration, data volume, certificates and port stay unchanged. Before the
   switch it writes `rollback.images.yaml` with the previous image tags.
4. Check health, the UI and your brokers ([operations](OPERATIONS.md)).

If your project uses another Compose project name, run `QH_PROJECT=<name> ./install.sh`.

## Rollback

From the new package directory, reuse the same Compose arguments with the rollback override last:

```sh
docker compose -p queuehunter-onprem --project-directory /opt/queuehunter \
  --env-file /opt/queuehunter/.env \
  -f /opt/queuehunter/compose.prebuilt.yaml \
  -f rollback.images.yaml up -d --no-deps api frontend
```

Restore data only if a release note says the upgrade changed the data format, and only from a
verified backup taken before the upgrade.

**Never run `docker compose down -v`** during an upgrade or rollback: `-v` deletes the data volume.
