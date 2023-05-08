#!/bin/sh

docker_run() {
    docker run \
        --rm \
        --workdir /app \
        --volume "$PWD":/app \
        --user $(id --user ${USER}):$(id --group ${USER}) \
        $@
}
