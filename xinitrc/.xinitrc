#!/bin/sh
xrdb -load ~/.Xresources

DISTRO="$(cat /etc/os-release | grep '^ID=' | cut -d '=' -f2 | tr -d '"')"

case $DISTRO in
  alpine) exec herbstluftwm ;;
  arch) exec herbstluftwm   ;;
  debian) exec herbstluftwm ;;
  void) exec i3             ;;
  *) exec qtile start       ;;
esac

# exec bspwm
# exec herbstluftwm
# exec i3
# exec qtile start
