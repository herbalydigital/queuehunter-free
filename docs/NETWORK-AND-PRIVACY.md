# Network access and data handling

## Outbound connections

| Destination | Purpose | Data sent |
|---|---|---|
| `api.keygen.sh` (HTTPS) | License validation at start and once a day | License key, a random installation id, the machine name `QueueHunter on-prem` |
| Your RabbitMQ / Kafka brokers | Message capture | Broker credentials you configure |

QueueHunter sends **no message contents, broker names or usage telemetry** to us or to the
license service. Captured messages stay on your server.

## Data stored locally

The Docker volume `queuehunter-onprem_queuehunter-data` contains the SQLite database with captured
message payloads, headers and metadata, the random installation id and the license validation
cache. Captured payloads can include personal or confidential data from your systems: protect
the server, its backups and the web port accordingly, and remove data you no longer need.

## Effect on your brokers

- **RabbitMQ:** QueueHunter declares and consumes only its own capture queue, dead-letter exchange
  and dead-letter queue. It checks your exchange and source queue passively and never publishes
  to, changes or consumes from them.
- **Kafka:** QueueHunter reads with its own consumer group and does not commit offsets. It never
  produces messages.

See the [Privacy Policy](https://queuehunter.com/legal/privacy.en.html) for how we handle the email address
you use to request a trial key.
