#!/bin/sh

. "$ZDOTDIR"/scripts/docker_run.sh

composer() {
    docker_run composer/composer $1
}
