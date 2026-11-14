# Operations and health checks

Run the commands from the installation directory (for example `/opt/queuehunter`).

| Task | Command |
|---|---|
| Status | `docker compose -p queuehunter-onprem -f compose.prebuilt.yaml ps` |
| Logs | `docker compose -p queuehunter-onprem -f compose.prebuilt.yaml logs --tail=100 api frontend` |
| Restart | `docker compose -p queuehunter-onprem -f compose.prebuilt.yaml restart` |
| Stop (keeps data) | `docker compose -p queuehunter-onprem -f compose.prebuilt.yaml stop` |
| Start | `docker compose -p queuehunter-onprem -f compose.prebuilt.yaml up -d` |

## Health endpoints

- `GET /healthz` — the web proxy and API are running.
- `GET /api/license/status` — license state (`active`, `offline_grace`, `inactive` = expired,
  `invalid`, `unavailable`, `unconfigured`), edition and expiry. Remove the key before sharing the output.
- `GET /api/config` — which brokers are configured and enabled.

Both containers have Docker health checks; the web container starts after the API is healthy.

## License checks

The API validates the license at start and then once a day. If the license service is
temporarily unreachable, QueueHunter keeps working for up to 3 days after the last successful
check. The trial ends 30 days after the key was issued; afterwards the UI shows the license as
expired and stops showing messages.

## Uninstall

```sh
docker compose -p queuehunter-onprem -f compose.prebuilt.yaml down      # keeps the data volume
docker volume rm queuehunter-onprem_queuehunter-data                  # deletes captured data
```

Then remove the RabbitMQ capture queue, DLX and DLQ (and the Kafka consumer group, if you want)
from your brokers, and delete the installation directory.
