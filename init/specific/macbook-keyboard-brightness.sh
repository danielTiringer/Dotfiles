#!/bin/sh

# Allow non-root editing of the brightness controls for my macbook pro 2010

MACBOOK_BRIGHTNESS_LOCATION=/sys/class/leds/smc::kbd_backlight/brightness
if [ -f "$MACBOOK_BRIGHTNESS_LOCATION" ] ; then
	sudo chmod 777 "$MACBOOK_BRIGHTNESS_LOCATION"
fi
