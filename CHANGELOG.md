# Changelog

Only versions published in this repository are listed. Each entry links to its GitHub release,
which contains the package, its checksum and the software bill of materials.

## [0.1.22](https://github.com/herbalydigital/queuehunter-free/releases/tag/v0.1.22) — 2026-11-23

- Message details are easier to read: the payload comes first, with a collapsible tree view
  (Expand all / Collapse all), a plain text view and one-click copy.
- Broker headers and properties are shown decoded: readable text instead of Base64 where the bytes
  are text, with the raw values still available.

## [0.1.21](https://github.com/herbalydigital/queuehunter-free/releases/tag/v0.1.21) — 2026-11-23

- Fixed: a Kafka or RabbitMQ message that is not valid JSON (binary data or broken UTF-8) no longer
  stops capturing. QueueHunter keeps its original bytes in the new **Capture quarantine** list (up
  to 256 KiB per message, with its size and SHA-256) and continues with the next message.
- The quarantine list shows the broker coordinates, reason and content of each entry. Replaying a
  quarantined message with its original bytes is a write action and needs Team or Enterprise.
- Fixed: any valid JSON value is captured, including very large numbers and deeply nested
  documents.

## [0.1.20](https://github.com/herbalydigital/queuehunter-free/releases/tag/v0.1.20) — 2026-11-23

Includes the Free changes of 0.1.16-tagline.1 to 0.1.19, which were not published separately here.

**Before you upgrade:** if you open QueueHunter through an IP address or host name that is not
listed in `CORS_ORIGINS`, add it to `QUEUEHUNTER_ALLOWED_HOSTS` in your `.env` (comma-separated, no
scheme or port), for example `QUEUEHUNTER_ALLOWED_HOSTS=192.0.2.10,queuehunter.internal`.
Otherwise the page loads but the API answers "Host is not allowed". `localhost` and `127.0.0.1`
always work. Once this setting is present, it replaces the host names taken from `CORS_ORIGINS`,
so list every name you use.

- Security: the web image uses nginx 1.31.9, which fixes the critical nginx vulnerability known as
  "nginx2root". Upgrading is strongly recommended.
- Security: with authentication turned off, the app rejects requests from other sites or through a
  foreign host name (cross-site request and DNS-rebinding protection).
- Security: the web image no longer ships the unused stock nginx configuration, nginx no longer
  reports its version, and the base images were updated to fix known medium-severity issues in
  system libraries.
- Fixed: Kafka broker health no longer stops the API on a new Kafka cluster where no consumer group
  has committed yet; lag that cannot be determined yet is shown as unknown. The API also answers
  the `/readyz` readiness check.
- Improved: scrollbars in message details, payload views, dialogs and tables match the dark
  interface in all major browsers.
- Changed: the app uses the "Message debugging" tagline; the install guide explains that
  `KAFKA_GROUP_ID` must be QueueHunter's own consumer group.
- Third-party notices: each release now lists every GPL, LGPL and MPL component with the public
  location of its source (`queuehunter-free-0.1.20-sources.md`).

## [0.1.16-package-text.1](https://github.com/herbalydigital/queuehunter-free/releases/tag/v0.1.16-package-text.1) — 2026-11-14

First public release of QueueHunter Free.

- Self-hosted RabbitMQ and Kafka message capture, search and payload/header inspection.
- Read-only 30-day trial; recent message history limited to the last 24 hours and 5 events per
  message.
- Non-intrusive capture: a separate RabbitMQ capture queue and an independent Kafka consumer group
  without offset commits.
- Hardened containers: digest-pinned base images, read-only root file systems, non-root API user.
- Installer with checksum verification, private `.env` creation and preserving upgrades with
  rollback image overrides.
