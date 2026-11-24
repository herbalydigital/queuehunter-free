# Third-party notices

The QueueHunter container images are built on third-party open-source components, including:

- **API image:** a digest-pinned Wolfi base image, Python 3.11 and hash-locked Python runtime
  packages (for example FastAPI, Uvicorn, Pydantic, pika, confluent-kafka/librdkafka, httpx).
- **Web image:** a digest-pinned Chainguard Nginx base image and the compiled web UI, whose
  JavaScript dependencies are listed in `web-package-lock.json` inside the release archive.

Each component remains subject to its own license. The complete component list with versions
and licenses is published with every release as a CycloneDX software bill of materials:

- `queuehunter-free-0.1.24-api.cdx.json`
- `queuehunter-free-0.1.24-web.cdx.json`

Exact base-image digests and the image IDs of a release are recorded in `qh-release.json` inside
the release archive.

Some components are licensed under the GNU GPL, LGPL or the Mozilla Public License (for example
glibc, BusyBox, GNU Readline and gdbm in the base images, and the `ldap3` Python package). They are
separate programs and libraries shipped unmodified in the images; their licenses keep applying to
them, and nothing in the QueueHunter license restricts the rights those licenses give you.
QueueHunter's own code is not licensed under these terms. Apache-2.0 components keep their own
NOTICE files.

**Source code.** Every such component of a release, with its exact version and the public location
of its complete corresponding source, is listed in `queuehunter-free-0.1.24-sources.md`, published with the release
next to the SBOMs. If a location is unavailable, we provide that source on request, at no charge
beyond our actual cost of making the copy, for at least three years after we last distributed the
release. Send requests to support@queuehunter.com and name the release and the component.

For other license texts or notices a component's license requires us to provide, contact us at
the same address or through https://queuehunter.com/.
