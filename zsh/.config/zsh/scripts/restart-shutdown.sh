#!/bin/sh
# Restart or shutdown the system

CURRENT_DIR="$(dirname "$(realpath "$0")")"
. "$CURRENT_DIR"/helpers.sh

restart() {
    if [ -d "/etc/systemd/" ] && [ -d "/etc/apt" ] ; then
        sudo systemctl reboot
    else
        sudo reboot
    fi
}

shutdown() {
    if [ -d "/etc/systemd/" ] && [ -d "/etc/apt" ] ; then
        sudo systemctl poweroff
    else
        sudo poweroff
    fi
}
