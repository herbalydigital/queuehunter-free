# Configuration

All settings live in the private `.env` file next to `compose.prebuilt.yaml`. After a change,
apply it with:

```sh
docker compose -p queuehunter-onprem -f compose.prebuilt.yaml up -d
```

Keep `.env` at mode 600, out of version control and out of support requests.

## General

| Setting | Default | Meaning |
|---|---|---|
| `LICENSE_KEY` | — | Your trial license key. Required. |
| `PORT` | `5173` | Host port (optionally `address:port`) of the web UI. |
| `POLL_INTERVAL_SECONDS` | `2` | How often the UI refreshes (1–300). |
| `CORS_ORIGINS` | `http://localhost:5173` | Extra browser origins allowed to call the API, comma separated. |
| `MAX_PAYLOAD_SIZE_MB` | `10` | Optional, not in the example: request size limit of the web proxy (1–1024). |

`API_PORT`, `QUEUEHUNTER_DB_PATH` and `LICENSE_DATA_DIR` are fixed by the Compose file to the
container's data volume; changing them in `.env` has no effect.

## RabbitMQ

QueueHunter never consumes from your queues. It binds its own **capture queue** to an existing
exchange, so it receives a copy of each message routed by that exchange while your consumers keep
working unchanged.

| Setting | Meaning |
|---|---|
| `RABBITMQ_ENABLED` | `false` disables RabbitMQ capture. |
| `RABBITMQ_URL` | `amqp://` or `amqps://` URL of the broker, including the account. |
| `RABBITMQ_DOCKER_URL` | Optional URL used from inside the container, if it differs (for a broker on the same host use `host.docker.internal`). |
| `RABBITMQ_SOURCE_QUEUE` | The queue you want to observe. It must exist; it is only checked, never bound or consumed. |
| `RABBITMQ_DECLARE_SOURCE_QUEUE` | Keep `false`. `true` only for an isolated test broker. |
| `RABBITMQ_CAPTURE_EXCHANGE` | The **existing** exchange that routes to your source queue. It is checked passively and never created or changed. |
| `RABBITMQ_CAPTURE_EXCHANGE_TYPE` | Type of that exchange (`fanout`, `direct`, `topic`). |
| `RABBITMQ_CAPTURE_ROUTING_KEY` | Binding key for the capture queue (for direct/topic exchanges use the same key as your source queue's binding). |
| `RABBITMQ_MIRROR_QUEUE` | Name of QueueHunter's capture queue (default `queuehunter-capture`). |
| `RABBITMQ_DLX`, `RABBITMQ_DLQ` | Dead-letter exchange and queue for capture messages QueueHunter cannot store. |
| `RABBITMQ_PREFETCH_COUNT` | Unacknowledged capture messages per consumer (default 10). |
| `DB_RETRY_ATTEMPTS`, `DB_RETRY_DELAY_SECONDS` | Retries when writing to the local database. |

The broker account needs configure, write and read permissions on QueueHunter's own capture
queue, DLX and DLQ, and read permission on the capture exchange (to bind the capture queue). The capture queue is
durable, so it keeps collecting copies while QueueHunter is stopped; delete it in RabbitMQ when
you uninstall QueueHunter.

## Kafka

QueueHunter subscribes to one topic as an **independent consumer group** and never commits
offsets, so it does not affect your applications' consumer groups. It starts from the newest
messages (`latest`).

| Setting | Meaning |
|---|---|
| `KAFKA_ENABLED` | `false` disables Kafka capture. |
| `KAFKA_BOOTSTRAP_SERVERS` | `host:port` list of the brokers. |
| `KAFKA_DOCKER_BOOTSTRAP_SERVERS` | Optional bootstrap list used from inside the container. |
| `KAFKA_TOPIC` | Topic to capture. |
| `KAFKA_GROUP_ID` | QueueHunter's **own** consumer group. Leave empty to use `queuehunter-<installation id>`. |
| `KAFKA_SECURITY_PROTOCOL` | `PLAINTEXT`, `SSL`, `SASL_PLAINTEXT` or `SASL_SSL`. |
| `KAFKA_SASL_MECHANISM` | For example `PLAIN`, `SCRAM-SHA-256`, `SCRAM-SHA-512`. |
| `KAFKA_SASL_USERNAME`, `KAFKA_SASL_PASSWORD` | SASL account. |
| `KAFKA_SSL_CA_LOCATION` | CA file path inside the container, for example `/run/certs/kafka-ca.crt`. |

> **Important:** `KAFKA_GROUP_ID` must never be the group of one of your applications. Members
> of the same group share the topic's partitions, so QueueHunter would take partitions away from
> your consumers. Use the empty default or a dedicated name such as `queuehunter-observer`.

The Kafka account needs read and describe on the topic and read on QueueHunter's group.

## Access control

QueueHunter Free has no built-in user sign-in. Anyone who can reach the web port can read the
captured messages, so restrict access to it; see [HTTPS and remote access](INSTALL.md#https-and-remote-access).
