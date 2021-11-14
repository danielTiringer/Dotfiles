#!/bin/sh
xrdb -load ~/.Xresources

DISTRO="$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')"

case $DISTRO in
  alpine) exec herbstluftwm --locked  ;;
  arch) exec qtile start              ;;
  debian) exec qtile start            ;;
  fedora) exec herbstluftwm --locked  ;;
  *) exec qtile start                 ;;
esac
