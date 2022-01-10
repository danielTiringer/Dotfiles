#!/bin/sh

CONNECTION='No Connection'

if [ $(grep -r 'up' /sys/class/net/en*/operstate | wc -l) -gt 0 ] ; then
    CONNECTION=' Wired'
fi

if [ $(cat /sys/class/net/wl*/operstate) = 'up' ] ; then
    WIRELESS_NAME=$(nmcli device status | grep 'wl*' | tr -s ' ' | cut -d ' ' -f4)
    CONNECTION=" ${WIRELESS_NAME}"
fi

echo $CONNECTION
