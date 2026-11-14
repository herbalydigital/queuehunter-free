# Security policy

## Supported versions

Only the [latest release](https://github.com/herbalydigital/queuehunter-free/releases/latest) receives security fixes. Please upgrade
before reporting an issue that may already be fixed ([upgrade guide](docs/UPGRADE.md)).

## Reporting a vulnerability

**Do not open a public issue for security problems.**

Report privately through GitHub:
[**Report a vulnerability**](https://github.com/herbalydigital/queuehunter-free/security/advisories/new).
If you cannot use GitHub, use the contact details on https://queuehunter.com/.

Please include:

- the QueueHunter version (`qh-release.json` in the release archive, or the image tags);
- what an attacker can do, and the preconditions;
- steps to reproduce, with **synthetic** data only.

Never send license keys, passwords, tokens, private keys, `.env` files or production message
contents. We will acknowledge your report, keep you informed about the fix, and credit you in the
release notes if you wish.

## Hardening reminders

- Do not publish the internal API port (8000); expose only the web port, ideally behind an HTTPS
  reverse proxy.
- Keep `.env` private (mode 600) and out of version control and support bundles.
- Use TLS to your brokers where available, and a dedicated, least-privilege broker account.
