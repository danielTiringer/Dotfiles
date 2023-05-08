#!/bin/sh

. "$ZDOTDIR"/scripts/docker_run.sh

shellcheck() {
    docker_run koalaman/shellcheck /app/"$1"
}
