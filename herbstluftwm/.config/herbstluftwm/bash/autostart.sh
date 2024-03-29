#!/usr/bin/env bash

PWD=$(dirname "$0")

# import configuration
. "$PWD"/color.sh
. "$PWD"/config.sh
. "$PWD"/helper.sh
. "$PWD"/statup.sh

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
# main

# background before wallpaper
set_background

hc emit_hook reload

hc lock

# remove all existing keybindings
hc keyunbind --all
hc mouseunbind --all
hc unrule -F

# reset theme
hc attr theme.tiling.reset 1
hc attr theme.floating.reset 1

set_tags_with_name

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
# do hash config
# hack associative array function argument passing using declare -p

configure 'keybind'   "$(declare -p keybinds)"
configure 'keybind'   "$(declare -p tagskeybinds)"
configure 'mousebind' "$(declare -p mousebinds)"
configure 'attr'      "$(declare -p attributes)"
configure 'set'       "$(declare -p sets)"
configure 'rule'      "$(declare -p rules)"
configure 'pad'       "$(declare -p pads)"

# avoid tilde problem, not using helper
hc rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off
hc rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on

hc set tree_style '╾│ ├└╼─┐'
# hc set tree_style '⊙│ ├╰»─╮'

# unlock, just to be sure
hc unlock

# detect multiple monitors
hc detect_monitors

start_panel

start_applications
