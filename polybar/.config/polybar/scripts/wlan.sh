#!/bin/sh

CONNECTION='No Connection'

if [ $(cat /sys/class/net/en*/operstate) = 'up' ] ; then
    CONNECTION=' Wired'
fi

if [ $(cat /sys/class/net/wl*/operstate) = 'up' ] ; then
    CONNECTION='  Wireless'
fi

echo $CONNECTION
