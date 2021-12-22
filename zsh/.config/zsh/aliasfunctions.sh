#!/bin/sh

. "$ZDOTDIR"/init.sh
. "$ZDOTDIR"/scripts/composer.sh
. "$ZDOTDIR"/scripts/docker_run.sh
. "$ZDOTDIR"/scripts/extract.sh
. "$ZDOTDIR"/scripts/shellcheck.sh
. "$ZDOTDIR"/updates.sh

if [ -d "$ZDOTDIR"/scripts/bitwarden-wrapper ] ; then
    bitwarden() {
        python3 "$ZDOTDIR"/scripts/bitwarden-wrapper/main.py
    }
fi
