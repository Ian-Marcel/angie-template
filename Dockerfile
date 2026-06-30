FROM docker.angie.software/angie:templated

ENV UID=100
ENV GID=101

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["angie", "-g", "daemon off;"]
