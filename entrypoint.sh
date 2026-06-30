#!/bin/sh

angie() {
    docker exec desktop-angie angie $@
}

angie -V >/tmp/angie-build 2>&1

cat /tmp/angie-build | tr ' ' '\n' | grep path | cut -d= -f2
