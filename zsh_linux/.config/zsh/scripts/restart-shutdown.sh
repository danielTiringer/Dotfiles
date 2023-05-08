#!/bin/sh
# Restart or shutdown the system

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
