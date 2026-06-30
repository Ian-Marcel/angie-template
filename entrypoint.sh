#!/bin/sh

if [ "$UID" != 100 ]; then
    angie -V >/tmp/angie-build 2>&1
    deluser angie
    addgroup -g ${GID} angie &&
        adduser -u ${UID} -G angie -s /sbin/nologin -D angie &&
        addgroup angie www-data &&
        chown $UID:$GID -R $(cat /tmp/angie-build | tr ' ' '\n' | grep path | cut -d= -f2 | tr '\n' ' ') 2>/dev/null
fi

exec "$@"
