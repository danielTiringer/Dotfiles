#!/bin/sh

DISTRO=$(cat /etc/os-release | grep "^ID=" | cut -d "=" -f2 | tr -d '"')

case $DISTRO in
    alpine) echo ""        ;;
    arch) echo ""          ;;
    debian) echo ""        ;;
    fedora) echo ""        ;;
    opensuse) echo ""      ;;
    *) echo ""             ;;
esac
