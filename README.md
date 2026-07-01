# Angie Docker Image (Templated)

This Docker image extends Angie’s templated base to support custom user permissions and group configurations, addressing issue #162 (permission conflicts in shared environments).

## Key Features

- Non-root execution: Runs Angie under a dedicated user (UID=100 by default).
- Group alignment: Ensures www-data (common for web servers) has access to Angie’s files.
- Templated flexibility: Inherits Angie’s templating capabilities while enforcing custom permissions.

## Usage

### docker run

```bash
docker run --rm -e UID=1000 -e GID=1000 \
  -v ./html:/usr/share/angie/html:ro \
  -p 8080:80 myangie
```

### docker compose

```yaml
services:
  angie:
    build: .
    environment:
      UID: "1000"
      GID: "1000"
    ports:
      - "8080:80"
```

## Use Cases

- Deploying Angie in shared hosting or multi-user environments where permission isolation is critical.
- Avoiding root privileges for security and compliance.
