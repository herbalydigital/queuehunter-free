# System requirements

- **OS / CPU:** Linux on x86-64 (amd64). ARM images are not provided.
- **Container runtime:** a current, supported Docker Engine with the Docker Compose v2 plugin
  (`docker compose version`).
- **Resources:** at least 1 vCPU and 1 GB RAM for small workloads; disk for the captured
  messages (plan for your message volume × size; the packages themselves need about 300 MB).
- **Tools on the host:** `sh`, `tar`, `sha256sum`, `grep`.
- **Network:** outbound HTTPS (443) to `api.keygen.sh` for license validation; network access to
  your RabbitMQ (AMQP 5672 / AMQPS 5671) and/or Kafka brokers; an inbound port for the web UI
  (default 5173), ideally limited to trusted users.
- **Browsers:** current versions of Chrome, Edge, Firefox or Safari.
- **Brokers:** RabbitMQ with AMQP 0-9-1; Apache Kafka or a Kafka-compatible broker with consumer
  groups.
