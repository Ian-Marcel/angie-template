# Base image: Angie's official Alpine-based "templated" variant.
FROM docker.angie.software/angie:templated

# Default UID/GID for the angie user; override at build/run time.
ENV UID=100
ENV GID=101

# Custom entrypoint that remaps UID/GID before Angie starts.
COPY ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Default command, run in foreground so Docker can supervise it.
CMD ["angie", "-g", "daemon off;"]
