# Third-party notices

The QueueHunter container images are built on third-party open-source components, including:

- **API image:** a digest-pinned Wolfi base image, Python 3.11 and hash-locked Python runtime
  packages (for example FastAPI, Uvicorn, Pydantic, pika, confluent-kafka/librdkafka, httpx).
- **Web image:** a digest-pinned Chainguard Nginx base image and the compiled web UI, whose
  JavaScript dependencies are listed in `web-package-lock.json` inside the release archive.

Each component remains subject to its own license. The complete component list with versions
and licenses is published with every release as a CycloneDX software bill of materials:

- `queuehunter-free-0.1.16-package-text.1-api.cdx.json`
- `queuehunter-free-0.1.16-package-text.1-web.cdx.json`

Exact base-image digests and the image IDs of a release are recorded in `qh-release.json` inside
the release archive.

If you need the license text or source code that a component's license requires us to provide,
contact us through https://queuehunter.com/.
