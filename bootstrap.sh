#!/usr/bin/env bash

DOTFILEDIR="$(dirname $(realpath "$0"))"

source "${DOTFILEDIR}/init/helper.sh"
DISTRO=$(check_distro)

INITDIR="${DOTFILEDIR}/init"

DISTROSCRIPT="${INITDIR}/${DISTRO}.sh"

if [ -f "${DISTROSCRIPT}" ] ; then
  source "${DISTROSCRIPT}"
else
  echo "No install script was found for ${DISTRO}."
fi
