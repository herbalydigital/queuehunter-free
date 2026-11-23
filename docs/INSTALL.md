# Installation

This guide installs QueueHunter Free 0.1.22 on one Linux server with Docker Compose.

## 1. Prepare

- Check the [system requirements](SYSTEM-REQUIREMENTS.md).
- Request a free trial license key on [queuehunter.com](https://queuehunter.com/#pricing).
- Collect the connection details of the broker(s) you want to observe (see
  [configuration](CONFIGURATION.md)). Use a dedicated, least-privilege broker account.

## 2. Download and verify

Download `queuehunter-free-0.1.22.tar.gz` and `queuehunter-free-0.1.22.tar.gz.sha256` from the
[latest release](https://github.com/herbalydigital/queuehunter-free/releases/latest) into the same directory:

```sh
sha256sum -c queuehunter-free-0.1.22.tar.gz.sha256
sudo mkdir -p /opt/queuehunter
sudo tar -xzf queuehunter-free-0.1.22.tar.gz -C /opt/queuehunter
cd /opt/queuehunter
```

Keep this directory: it holds your `.env`, the Compose file and the certificates folder.
The installer verifies every file against `SHA256SUMS` before it does anything.

## 3. Create the configuration

```sh
./install.sh
```

The first run copies `env.example` to a private `.env` (mode 600) and stops. It never
overwrites an existing `.env`.

Edit `.env`:

- `LICENSE_KEY` — your trial key (required);
- RabbitMQ and/or Kafka settings — see [configuration](CONFIGURATION.md);
- set `RABBITMQ_ENABLED=false` or `KAFKA_ENABLED=false` for a broker you do not use.

## 4. Start

```sh
./install.sh
```

The second run loads the container images from `images.tar` and starts the Compose project
`queuehunter-onprem` with two containers, `api` and `frontend`.

Check the result:

```sh
docker compose -f compose.prebuilt.yaml ps
curl -fsS http://127.0.0.1:5173/healthz
curl -fsS http://127.0.0.1:5173/api/license/status
```

Open `http://<server>:5173/`. The web port is set by `PORT` in `.env` (default 5173).

## HTTPS and remote access

QueueHunter Free has no built-in user sign-in: anyone who can reach the web port can read the
captured messages. Therefore:

- keep the port reachable only from trusted networks (firewall, VPN or SSH tunnel), or
- publish it through an HTTPS reverse proxy that adds authentication, and bind QueueHunter to
  localhost by setting, for example, `PORT=127.0.0.1:5173` in `.env`.

Example for nginx in front of QueueHunter:

```nginx
server {
    listen 443 ssl;
    server_name queuehunter.example.internal;
    ssl_certificate     /etc/ssl/certs/queuehunter.crt;
    ssl_certificate_key /etc/ssl/private/queuehunter.key;
    auth_basic           "QueueHunter";
    auth_basic_user_file /etc/nginx/queuehunter.htpasswd;
    client_max_body_size 10m;
    location / {
        proxy_pass http://127.0.0.1:5173;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto https;
    }
}
```

Set `CORS_ORIGINS` to the public origin only if a browser calls the API from another origin;
the bundled web UI uses the same origin and needs no change.

Never publish the internal API port (8000).

## Broker TLS certificates

Put the CA certificates your brokers need into `certs/`; they are mounted read-only at
`/run/certs` in the API container. The API runs as user 10001, so the files must be readable
by that user, for example `chmod 644 certs/*.crt`. Reference them by container path, for
example `KAFKA_SSL_CA_LOCATION=/run/certs/kafka-ca.crt`.

## Next steps

- [Operations and health checks](OPERATIONS.md)
- [Backup and restore](BACKUP-AND-RESTORE.md)
- [Upgrade and rollback](UPGRADE.md)
