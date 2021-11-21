#!/bin/sh

# Entrypoint for the automated system installer

DOTFILEDIR="$(dirname $(realpath "$0"))"

INITDIR="${DOTFILEDIR}/init"
. "${INITDIR}/helper.sh"

DISTRO=$(check_distro)
DISTROSCRIPT="${INITDIR}/${DISTRO}.sh"

if [ ! -f "${DISTROSCRIPT}" ] ; then
  echo "No install script was found for ${DISTRO}."
  exit 1
fi

. "${DISTROSCRIPT}"
