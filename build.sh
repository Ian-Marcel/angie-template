#!/bin/sh

docker pull --quiet docker.angie.software/angie:templated

docker run -it --rm docker.angie.software/angie:templated angie -v | grep -i 'Angie version' | sed 's/[^0-9.]//g' >/tmp/angie-plus-version

docker build . --quiet --tag dockerizedian/angie-template-plus:$(cat /tmp/angie-plus-version)
docker build . --quiet --tag dockerizedian/angie-template-plus:latest

if [ ${1:-} = deploy ]; then
    docker push --all-tags --quiet dockerizedian/angie-template-plus
fi
