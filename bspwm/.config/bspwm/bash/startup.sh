#!/usr/bin/env bash

function set_mouse() {
    xsetroot -cursor_name left_ptr &
}

function start_applications() {
    pgrep -x sxhkd > /dev/null || sxhkd -c $XDG_CONFIG_HOME/sxhkd/common_sxhkdrc $XDG_CONFIG_HOME/sxhkd/bspwm_sxhkdrc &
    picom &
    feh --no-fehbg --bg-scale "$HOME/Pictures/dark-leaves.jpg" &
}

function start_panel() {
    $XDG_CONFIG_HOME/polybar/launch.sh mainbar-bspwm &
}
