#!/bin/sh

docker pull --quiet docker.angie.software/angie:templated

docker run -it --rm docker.angie.software/angie:templated angie -v | grep -i 'Angie version' | sed 's/[^0-9.]//g' >/tmp/angie-plus-version

if [ ${1:-} = deploy ]; then
    docker build . --quiet --tag dockerizedian/angie-template-plus:$(cat /tmp/angie-plus-version)
    docker build . --quiet --tag dockerizedian/angie-template-plus:latest

    docker push --all-tags --quiet dockerizedian/angie-template-plus
    docker image rm --all-tags dockerizedian/angie-template-plus
else
    docker build . --tag angie-template-plus-test_image
fi
