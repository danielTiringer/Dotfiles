#!/bin/sh

shellcheck() {
    CURRENT_DIR="$(pwd)"

    docker run --rm -w /app -v "$CURRENT_DIR":/app koalaman/shellcheck /app/"$1"
}
