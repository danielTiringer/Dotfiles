#!/bin/sh
# Restart or shutdown the system

restart() {
    if [ -d "/etc/systemd/" ] ; then
        sudo systemctl reboot
    else
        sudo reboot
    fi
}

shutdown() {
    if [ -d "/etc/systemd/" ] ; then
        systemctl poweroff
    else
        sudo poweroff
    fi
}
