# QueueHunter Free

**Find, inspect and trace stuck messages across RabbitMQ and Kafka — self-hosted.**

QueueHunter is a message debugging tool for development, staging and production.
It captures messages from RabbitMQ and Kafka into a local database and gives you a web UI to
search them, inspect payloads and headers, and follow a message's recent history.

**Website and free trial key:** [queuehunter.com](https://queuehunter.com/)

> QueueHunter Free is a **30-day evaluation** of the self-hosted product. It needs a free trial
> license key, which you request with your email address on [queuehunter.com](https://queuehunter.com/#pricing).
> No payment details are needed.

## What you get

| | QueueHunter Free (30-day trial) |
|---|---|
| Deployment | Self-hosted, Docker Compose, your own server |
| RabbitMQ and Kafka capture, search and inspection | ✓ |
| Recent message history | ✓ last 24 hours, up to 5 events per message |
| Edit and replay captured messages | — (read-only) |
| Full message history and related messages | — |
| Kafka consumer-group lag and RabbitMQ queue/consumer health | — |

The trial is read-only: QueueHunter never publishes, edits or removes messages on your brokers in
this edition. It reads RabbitMQ through a separate capture queue, and Kafka with its own consumer group
without committing offsets.

## Quick start

Requirements: Linux x86-64, Docker Engine with Docker Compose v2, outbound HTTPS for license
validation and network access to your brokers. See [system requirements](docs/SYSTEM-REQUIREMENTS.md).

1. **Get a trial license key** on [queuehunter.com](https://queuehunter.com/#pricing).
2. **Download** `queuehunter-free-0.1.25.tar.gz` and its `.sha256` from the
   [latest release](https://github.com/herbalydigital/queuehunter-free/releases/latest), then verify and extract it:
   ```sh
   sha256sum -c queuehunter-free-0.1.25.tar.gz.sha256
   mkdir -p /opt/queuehunter && tar -xzf queuehunter-free-0.1.25.tar.gz -C /opt/queuehunter
   cd /opt/queuehunter
   ```
3. **Create your private configuration** (the first run only creates `.env` and stops):
   ```sh
   ./install.sh
   ```
4. **Edit `.env`:** set `LICENSE_KEY` and the broker(s) you want to observe
   ([configuration guide](docs/CONFIGURATION.md)).
5. **Start QueueHunter:**
   ```sh
   ./install.sh
   ```
6. Open `http://<server>:5173/`. For access from other machines, put QueueHunter behind an HTTPS
   reverse proxy ([installation guide](docs/INSTALL.md#https-and-remote-access)).

## Documentation

- [Installation](docs/INSTALL.md)
- [Configuration](docs/CONFIGURATION.md)
- [Upgrade and rollback](docs/UPGRADE.md)
- [Backup and restore](docs/BACKUP-AND-RESTORE.md)
- [Operations and health checks](docs/OPERATIONS.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)
- [System requirements](docs/SYSTEM-REQUIREMENTS.md)
- [Network access and data handling](docs/NETWORK-AND-PRIVACY.md)
- [Changelog](CHANGELOG.md)

The [`package/`](package/) folder mirrors the installer scripts and Compose files of the current
release, so you can review them before downloading. Always install from the release archive,
which also contains the container images and the checksums.

## Support

- **Bugs and questions:** open an [issue](https://github.com/herbalydigital/queuehunter-free/issues/new/choose), or use the bug report
  form on [queuehunter.com](https://queuehunter.com/).
- **Security issues:** please do not open a public issue; see [SECURITY.md](SECURITY.md).
- Never include license keys, passwords, tokens, private keys or production message contents in
  issues, logs or screenshots.

See [SUPPORT.md](SUPPORT.md) for what to include in a report.

## License

QueueHunter Free is free of charge but proprietary, **not open source**. Use is governed by the
[QueueHunter Free License](LICENSE.md) (Hungarian governing text: [LICENSE.hu.md](LICENSE.hu.md)).
The source code is not published. The container images include third-party open-source
components under their own licenses; see [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md).

QueueHunter is not affiliated with or endorsed by the RabbitMQ or Apache Kafka projects.
RabbitMQ is a trademark of Broadcom; Apache Kafka is a trademark of the Apache Software Foundation.
