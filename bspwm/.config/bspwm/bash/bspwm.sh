#!/bin/sh

PWD=$(dirname "$0")
. "$PWD"/startup.sh

# Autostart
set_mouse
start_applications
start_panel

# Workspaces
bspc monitor -d DEV DOCKER SYS DOC WWW TEST MEDIA VMAN HOMELAB

# Configuration
bspc config border_width  2
bspc config split_ratio   0.5
bspc config top_padding   20
bspc config window_gap    5

bspc config normal_border_color '#565656'
bspc config active_border_color '#2aa198'
bspc config focused_border_color '#2aa198'
