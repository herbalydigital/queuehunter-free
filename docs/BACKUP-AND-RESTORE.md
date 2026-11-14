# Backup and restore

QueueHunter keeps its state in three places:

| What | Where |
|---|---|
| Configuration | `.env` in the installation directory (contains secrets) |
| Broker CA certificates | `certs/` in the installation directory |
| Captured messages, history, installation id, license cache | Docker volume `queuehunter-onprem_queuehunter-data` |

## Back up

```sh
cd /opt/queuehunter
docker compose -p queuehunter-onprem -f compose.prebuilt.yaml stop api
docker run --rm -v queuehunter-onprem_queuehunter-data:/data:ro -v "$PWD":/backup alpine \
  tar -czf /backup/queuehunter-data-$(date +%Y%m%d).tar.gz -C /data .
docker compose -p queuehunter-onprem -f compose.prebuilt.yaml start api
(umask 077; tar -czf queuehunter-config-$(date +%Y%m%d).tar.gz .env certs)
```

Stopping the API for a moment makes the SQLite database consistent. Store the archives on
protected storage: they contain your configuration secrets and captured message contents.

## Restore

```sh
cd /opt/queuehunter
docker compose -p queuehunter-onprem -f compose.prebuilt.yaml stop api frontend
docker run --rm -v queuehunter-onprem_queuehunter-data:/data -v "$PWD":/backup alpine \
  sh -c 'find /data -mindepth 1 -delete && tar -xzf /backup/queuehunter-data-YYYYMMDD.tar.gz -C /data && chown -R 10001:10001 /data'
docker compose -p queuehunter-onprem -f compose.prebuilt.yaml up -d
```

Restore `.env` and `certs/` from the configuration archive when needed. Restore a data backup
only into the version that created it or a newer one.
