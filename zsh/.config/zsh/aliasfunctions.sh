#!/bin/sh

. "$ZDOTDIR"/scripts/init.sh
. "$ZDOTDIR"/scripts/docker_run.sh
. "$ZDOTDIR"/scripts/extract.sh
. "$ZDOTDIR"/scripts/restart-shutdown.sh
. "$ZDOTDIR"/scripts/shellcheck.sh
. "$ZDOTDIR"/scripts/updates.sh

if [ -d "$ZDOTDIR"/scripts/bitwarden-wrapper ] ; then
    bitwarden() {
        python3 "$ZDOTDIR"/scripts/bitwarden-wrapper/main.py
    }
fi
