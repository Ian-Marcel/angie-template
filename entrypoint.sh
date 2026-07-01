#!/bin/sh

# Only remap the user if UID differs from the image default.
if [ "$UID" != 100 ]; then
    # Get Angie's compiled-in paths (prefix, logs, pid, temp dirs, etc.)
    angie -V >/tmp/angie-build 2>&1
    # Remove the built-in angie user/group so it can be recreated below.
    deluser angie
    # Recreate angie with the requested UID/GID, add it to www-data,
    # then chown every path found in `angie -V` to the new UID:GID.
    addgroup -g ${GID} angie &&
        adduser -u ${UID} -G angie -s /sbin/nologin -D angie &&
        addgroup angie www-data &&
        chown $UID:$GID -R $(cat /tmp/angie-build | tr ' ' '\n' | grep path | cut -d= -f2 | tr '\n' ' ') 2>/dev/null
fi
# Replace this shell with the actual CMD (PID 1 -> Angie).
exec "$@"
