#!/bin/sh

DOTFILEDIR="$(dirname $(realpath "$0"))"

. "${DOTFILEDIR}/init/helper.sh"
DISTRO=$(check_distro)

INITDIR="${DOTFILEDIR}/init"

DISTROSCRIPT="${INITDIR}/${DISTRO}.sh"

if [ ! -f "${DISTROSCRIPT}" ] ; then
  echo "No install script was found for ${DISTRO}."
  exit 1
fi

. "${DISTROSCRIPT}"
