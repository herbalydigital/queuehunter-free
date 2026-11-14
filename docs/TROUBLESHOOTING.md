# Troubleshooting

Start with `docker compose -p queuehunter-onprem -f compose.prebuilt.yaml ps` and the logs
(`... logs --tail=100 api frontend`).

| Symptom | Likely cause and fix |
|---|---|
| `sha256sum` reports `FAILED` | Incomplete or modified download. Download the package again. |
| `Set LICENSE_KEY in your private .env` | `LICENSE_KEY` is empty or commented out in `.env`. |
| `Existing installation: use install.sh` | `setup.sh` found a running installation; run `./install.sh` instead. |
| License status `invalid` or `inactive` | Wrong key, or the 30-day trial has ended. Check the key; request help via the website. |
| License status `offline_grace` or `unavailable` | No outbound HTTPS to `api.keygen.sh`. Allow it, or set `HTTPS_PROXY` (and `NO_PROXY` for your brokers) in `.env`. |
| License status `unconfigured` | `LICENSE_KEY` is missing from the running container's environment; set it and run `up -d`. |
| Web UI does not load | Check `PORT`, the host firewall, and that `frontend` is healthy. |
| No RabbitMQ messages | Wrong exchange, type or routing key; the capture queue must receive copies of what reaches your source queue. Check the `queuehunter-capture` queue in the RabbitMQ management UI. |
| `NOT_FOUND - no exchange` / `no queue` in the logs | `RABBITMQ_CAPTURE_EXCHANGE` or `RABBITMQ_SOURCE_QUEUE` does not exist. QueueHunter never creates them. |
| `ACCESS_REFUSED` | The RabbitMQ account lacks the permissions listed in [configuration](CONFIGURATION.md#rabbitmq). |
| No Kafka messages | QueueHunter starts at the newest offset; produce a new message. Check `KAFKA_TOPIC`, the security settings and the ACLs. |
| Your Kafka application lost partitions | `KAFKA_GROUP_ID` was set to the application's group. Clear it or use a dedicated name, then restart. |
| Broker on the same host is unreachable | Inside the container `localhost` is the container itself. Use `RABBITMQ_DOCKER_URL` / `KAFKA_DOCKER_BOOTSTRAP_SERVERS` with `host.docker.internal`. |
| TLS errors | The CA file must be under `certs/`, readable by user 10001, and referenced with its `/run/certs/...` path. |
| History shows only part of the events | Expected in Free: the last 24 hours, up to 5 events per message. |
| Edit or replay is not available | Expected: QueueHunter Free is read-only. |

Still stuck? See [SUPPORT.md](../SUPPORT.md).
