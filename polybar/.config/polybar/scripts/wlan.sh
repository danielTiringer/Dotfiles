#!/bin/sh

CONNECTION='No Connection'

if [ $(cat /sys/class/net/en*/operstate) = 'up' ] ; then
    CONNECTION=' Wired'
fi

if [ $(cat /sys/class/net/wl*/operstate) = 'up' ] ; then
    WIRELESS_NAME=$(nmcli device status | grep 'connected' | tr -s ' ' | cut -d ' ' -f4)
    CONNECTION=" ${WIRELESS_NAME}"
fi

echo $CONNECTION
