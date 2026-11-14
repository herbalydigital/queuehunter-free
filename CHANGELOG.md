# Changelog

Only versions published in this repository are listed. Each entry links to its GitHub release,
which contains the package, its checksum and the software bill of materials.

## 0.1.16-package-text.1 — 2026-11-14

First public release of QueueHunter Free.

- Self-hosted RabbitMQ and Kafka message capture, search and payload/header inspection.
- Read-only 30-day trial; recent message history limited to the last 24 hours and 5 events per
  message.
- Non-intrusive capture: a separate RabbitMQ capture queue and an independent Kafka consumer group
  without offset commits.
- Hardened containers: digest-pinned base images, read-only root file systems, non-root API user.
- Installer with checksum verification, private `.env` creation and preserving upgrades with
  rollback image overrides.
