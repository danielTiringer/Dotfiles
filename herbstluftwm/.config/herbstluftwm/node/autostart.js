#!/usr/bin/env node
'use strict';

const colors = require('./color');
const { tags, config } = require('./config');
const { hc, setTagsWithName, configure } = require('./helper');
const { setBackground, startPanel, startApplications } = require('./startup');

// ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
// main

// background before wallpaper
setBackground();

hc('lock');

hc('emit_hook reload');

// remove all existing keybindings
hc('keyunbind --all');
hc('mouseunbind --all');
hc('unrule -F');

// reset theme
hc('attr theme.tiling.reset 1');
hc('attr theme.floating.reset 1');

// got to set tags here
setTagsWithName();

// ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----
// config from object

configure(config);

// avoid tilde problem, not using helper
hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off");
hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on");

hc("set tree_style '╾│ ├└╼─┐'");
// hc("set tree_style '⊙│ ├╰»─╮'");

// unlock, just to be sure
hc('unlock');

// detect multiple monitors
hc('detect_monitors');

startPanel();

startApplications();
