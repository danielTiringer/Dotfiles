#!/bin/sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Collect data used by the bar and set them into variables
export HEADPHONE_ID=$(amixer controls | grep "name='Headphone Jack'" | cut -d ',' -f1 | cut -d '=' -f2)

# Launch bar1 and bar2
for m in $(polybar --list-monitors | cut -d":" -f1); do
	MONITOR=$m polybar --config=$XDG_CONFIG_HOME/polybar/config.ini --reload $1 &
done
