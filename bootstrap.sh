#!/bin/sh

# Entrypoint for the automated system installer

if [[ "$OSTYPE" == "linux-gnu"* ]] ; then
  DOTFILEDIR="$(dirname "$(realpath "$0")")"

  INITDIR="$DOTFILEDIR/init"
  . "$INITDIR/helper.sh"

  DISTRO=$(check_distro)
  DISTROSCRIPT="$INITDIR/$DISTRO.sh"

  if [ ! -f "$DISTROSCRIPT" ] ; then
    echo "No install script was found for $DISTRO."
    exit 1
  fi

  . "$DISTROSCRIPT"
elif [[ "$OSTYPE" == "darwin"* ]] ; then
  DOTFILEDIR=$(cd "$(dirname "$0")"; pwd -P)
  INITDIR="$DOTFILEDIR/init"
  . "$INITDIR/mac.sh"
else
  echo "No install script was found for the $OSTYPE."
  exit 1
fi
