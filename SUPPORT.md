# Getting help

1. Check [Troubleshooting](docs/TROUBLESHOOTING.md) and the [Operations guide](docs/OPERATIONS.md).
2. Search the [existing issues](https://github.com/herbalydigital/queuehunter-free/issues).
3. Open a [new issue](https://github.com/herbalydigital/queuehunter-free/issues/new/choose), or use the bug report form on
   https://queuehunter.com/.

Security issues: follow [SECURITY.md](SECURITY.md) instead.

## What to include

- QueueHunter version and image tags (`docker compose -f compose.prebuilt.yaml images`)
- Host OS, Docker and Docker Compose versions
- Which broker(s): RabbitMQ and/or Kafka, and their versions
- What you did, what you expected, and what happened
- The output of `curl -fsS http://127.0.0.1:5173/api/license/status`, with the key removed
- Relevant log lines: `docker compose -f compose.prebuilt.yaml logs --tail=100 api frontend`

## What never to include

License keys, passwords, tokens, broker URLs with credentials, private keys, `.env` files,
company-confidential or personal data, and production message contents — in text, logs or
screenshots. Replace them with placeholders.

Support for the Free trial is best effort, through the issue tracker.
