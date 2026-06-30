#!/usr/bin/env bash

angie-build() {
    docker exec desktop-angie angie -V
}

angie-build | sed '1,2d'
