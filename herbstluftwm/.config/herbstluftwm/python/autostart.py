#!/usr/bin/env python3

import os

from color import color

import helper
from helper import hc

import config

import startup


# background before wallpaper
os.system(f"xsetroot -solid {color['purple']}")

hc('emit_hook reload')

hc("lock");

# remove all existing keybindings
hc('keyunbind --all')
hc('mouseunbind --all')
hc('unrule -F')

# reset theme
hc('attr theme.tiling.reset 1')
hc('attr theme.floating.reset 1')

helper.set_tags_with_name()

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----

helper.configure('keybind',   config.keybinds)
helper.configure('keybind',   config.tagskeybinds)
helper.configure('mousebind', config.mousebinds)
helper.configure('attr',      config.attributes)
helper.configure('set',       config.sets)
helper.configure('rule',      config.rules)
helper.configure('rule',      config.pads)

# avoid tilde problem, not using helper
hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off")
hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on")

hc("set tree_style '╾│ ├└╼─┐'")
# hc("set tree_style '⊙│ ├╰»─╮'")

# unlock, just to be sure
hc("unlock")

# detect multiple monitors
hc('detect_monitors')

startup.start_panel()
startup.start_applications()
