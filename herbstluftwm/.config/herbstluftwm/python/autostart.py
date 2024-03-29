#!/usr/bin/env python3

from helper import hc, configure, set_tags_with_name
from config import config
import startup


# background before wallpaper
startup.set_background()

hc('emit_hook reload')

hc('lock');

# remove all existing keybindings
hc('keyunbind --all')
hc('mouseunbind --all')
hc('unrule -F')

# reset theme
hc('attr theme.tiling.reset 1')
hc('attr theme.floating.reset 1')

set_tags_with_name()

# ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----

configure(config)

# avoid tilde problem, not using helper
hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off")
hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on")

hc("set tree_style '╾│ ├└╼─┐'")
# hc("set tree_style '⊙│ ├╰»─╮'")

# unlock, just to be sure
hc('unlock')

# detect multiple monitors
hc('detect_monitors')

startup.start_panel()
startup.start_applications()
