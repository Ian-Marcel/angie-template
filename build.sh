#!/bin/env bash

INDEX=0
nullifier=$RANDOM-null_$RANDOM
UPGRADE=false

docker pull --quiet docker.angie.software/angie:templated
OFICIAL_IMG_V=$(docker run -it --rm docker.angie.software/angie:templated angie -v | grep -i 'Angie version' | sed 's/[^0-9.]//g')
PLUS_IMG_V=$(docker run -it --rm dockerizedian/angie-template-plus:latest angie -v | grep -i 'Angie version' | sed 's/[^0-9.]//g')

echo "[ INFO ] Oficial angie image version: $OFICIAL_IMG_V"
echo "[ INFO ] angie-template-plus image version: $PLUS_IMG_V"

IFS=. read -ra PLUSVL < <(echo "$PLUS_IMG_V")
IFS=. read -ra OFICIALVL < <(echo "$OFICIAL_IMG_V")

while [ ${OFICIALVL[$INDEX]:-$nullifier} != $nullifier ]; do
    if [ ${OFICIALVL[$INDEX]} -gt ${PLUSVL[$INDEX]} ]; then
        UPGRADE=true
        echo "[ INFO ] Upgrade available!"
        break
    fi
    ((INDEX++))
done
if [ $UPGRADE = false ]; then
    echo '[ INFO ] Nothing new...'
    exit 0
fi

PLUSV=$(docker run -it --rm docker.angie.software/angie:templated angie -v | grep -i 'Angie version' | sed 's/[^0-9.]//g')

if [ "${1:-}" = "--deploy" ]; then
    echo "[ INFO ] Building dockerizedian/angie-template-plus:$PLUSV"
    docker build . --quiet --tag dockerizedian/angie-template-plus:"$PLUSV"
    echo "[ INFO ] Building dockerizedian/angie-template-plus:latest"
    docker build . --quiet --tag dockerizedian/angie-template-plus:latest

    echo "Pushing them to registry."
    docker push --all-tags --quiet dockerizedian/angie-template-plus || false
    if [ $? -gt 0 ]; then
        echo -e "[ FATAL ] Failed to push image to registry. Are you logged? \n[ FATAL ] Aborting entire operation!"
        docker image rm dockerizedian/angie-template-plus:$PLUSV >/dev/null 2>&1
        docker image rm dockerizedian/angie-template-plus:latest >/dev/null 2>&1
        exit 1
    fi
    echo "Images succesfuly pushed to registry!"
else
    echo "[ INFO ] Building dockerizedian/angie-template-plus:test"
    docker build . --quiet --tag dockerizedian/angie-template-plus:test
fi
