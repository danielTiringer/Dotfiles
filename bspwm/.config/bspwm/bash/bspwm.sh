#!/usr/bin/env bash

PWD=$(dirname "$0")
. "$PWD"/helper.sh
. "$PWD"/settings.sh
. "$PWD"/startup.sh

# Autostart
set_mouse
start_applications
start_panel

# Workspaces
bspc monitor -d DEV DOCKER SYS DOC WWW TEST MEDIA VMAN HOMELAB

# Configuration
configure "$(declare -p settings)"
