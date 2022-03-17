#!/usr/bin/env bash

picom &
feh --no-fehbg --bg-scale "$HOME/Pictures/dark-leaves.jpg" &
sxhkd -c $XDG_CONFIG_HOME/sxhkd/common_sxhkdrc &
