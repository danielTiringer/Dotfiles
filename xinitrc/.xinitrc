#!/bin/sh
xrdb -load ~/.Xresources

DISTRO="$(cat /etc/os-release | grep '^ID=' | cut -d '=' -f2 | tr -d '"')"

case $DISTRO in
  alpine) exec herbstluftwm --locked  ;;
  arch) exec herbstluftwm --locked    ;;
  debian) exec bspwm                  ;;
  fedora) exec i3                     ;;
  void) exec herbstluftwm --locked    ;;
  *) exec qtile start                 ;;
esac
