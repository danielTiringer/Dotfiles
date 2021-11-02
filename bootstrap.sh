#!/usr/bin/env bash

DOTFILEDIR="$(dirname $(realpath "$0"))"

source $DOTFILEDIR/init/helper.sh
DISTRO=$(check_distro)

INITDIR="${DOTFILEDIR}/init"

source $INITDIR/$DISTRO.sh
