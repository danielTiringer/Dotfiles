#!/usr/bin/env bash

function start_panel() {
    $XDG_CONFIG_HOME/polybar/launch.sh mainbar-herbst &

    # panel=~/.config/herbstluftwm/main.sh
    # [ -x "$panel" ] || panel=/etc/xdg/herbstluftwm/panel.sh
    # for monitor in $(herbstclient list_monitors | cut -d: -f1) ; do
    #     "$panel" $monitor &
    # done
}

function start_applications() {
    picom &
    feh --no-fehbg --bg-scale "$HOME/Pictures/dark-leaves.jpg" &
    sxhkd -c $XDG_CONFIG_HOME/sxhkd/common_sxhkdrc &
}
