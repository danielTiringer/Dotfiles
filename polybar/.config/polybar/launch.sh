#!/bin/sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Collect data used by the bar and set them into variables
HEADPHONE=$(amixer controls | grep "name='Headphone Jack'" | cut -d ',' -f1 | cut -d '=' -f2)
WIRELESS=$(ls /sys/class/net/ | grep ^wl | awk 'NR==1{print $1}')
WIRED=$(ls /sys/class/net/ | grep ^en | awk 'NR==1{print $1}')
INTERFACE=$WIRED
tail -n+3 /proc/net/wireless | grep -q . && INTERFACE=$WIRELESS

# Launch bar1 and bar2
for m in $(polybar --list-monitors | cut -d":" -f1); do
	HEADPHONE_ID=$HEADPHONE INTERFACE_NAME=$INTERFACE WIRELESS_INTERFACE=$WIRELESS WIRED_INTERFACE=$WIRED MONITOR=$m polybar --reload $1 &
done
