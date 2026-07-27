# angie-template+

This Docker image extends Angie's templated base to support custom user permissions and group configurations, addressing issue [#162](https://github.com/webserver-llc/angie/issues/162#issuecomment-4860549500).

## Key Features

- Non-root execution: Runs Angie under a dedicated user, can be edited through variables PUID and PGID (PUID=100 by default).
- Group alignment: Ensures www-data (common for web servers) has access to Angie’s files.
- Templated flexibility: Inherits Angie’s templating capabilities while enforcing custom permissions.

## Usage

### docker run

```bash
docker run -e PUID=1000 -e PGID=1000 \
  -v ./html:/usr/share/angie/html:ro \
  -p 8080:80 dockerizedian/angie-template-plus:latest
```

### docker compose

```yaml
services:
  angie:
    image: dockerizedian/angie-template-plus:latest
    environment:
      PUID: "1000"
      PGID: "1000"
    ports:
      - "8080:80"
```

## Use Cases

- Deploying Angie in shared hosting or multi-user environments where permission isolation is critical.
- Avoiding root privileges for security and compliance.
