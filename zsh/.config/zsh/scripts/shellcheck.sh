#!/bin/sh

shellcheck() {
    CURRENT_DIR="$(pwd)"

    docker run \
        --rm \
        --workdir /app \
        --volume "$CURRENT_DIR":/app \
        --user $(id --user ${USER}):$(id --group ${USER}) \
        koalaman/shellcheck /app/"$1"
}
