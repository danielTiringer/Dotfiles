#!/usr/bin/env bash

DOTFILEDIR="$(dirname $(realpath "$0"))"

source "${DOTFILEDIR}/init/helper.sh"
DISTRO=$(check_distro)

INITDIR="${DOTFILEDIR}/init"

DISTROSCRIPT="${INITDIR}/${DISTRO}.sh"

if ! [ -f "${DISTROSCRIPT}" ] ; then
  echo "No install script was found for ${DISTRO}."
  exit 1
fi

source "${DISTROSCRIPT}"
