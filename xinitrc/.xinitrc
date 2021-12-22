#!/bin/sh
xrdb -load ~/.Xresources

DISTRO="$(cat /etc/os-release | grep '^ID=' | cut -d '=' -f2 | tr -d '"')"

case $DISTRO in
  alpine) exec herbstluftwm --locked  ;;
  arch) exec herbstluftwm --locked    ;;
  debian) exec bspwm                  ;;
  void) exec bspwm                    ;;
  *) exec qtile start                 ;;
esac

# exec bspwm
# exec herbstluftwm --locked
# exec i3
# exec qtile start
