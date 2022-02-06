#!/usr/bin/env php
<?php

require_once 'Config.php';
require_once 'Color.php';
require_once 'Helper.php';
require_once 'Startup.php';

$color = new Color();
$config = new Config($color);
$helper = new Helper();
$startup = new Startup($color);

$startup->setBackground();

$helper->hc('lock');
$helper->hc('emit_hook reload');

// remove all existing keybindings
$helper->hc('keyunbind --all');
$helper->hc('mouseunbind --all');
$helper->hc('unrule -F');

// reset theme
$helper->hc('attr theme.tiling.reset 1');
$helper->hc('attr theme.floating.reset 1');

$helper->setTagsWithName($config->getTags());
$helper->configure($config->getSettings());

// avoid tilde problem, not using helper
$helper->hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off");
$helper->hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on");

$helper->hc("set tree_style '╾│ ├└╼─┐'");
// $helper->hc("set tree_style '⊙│ ├╰»─╮'");

// unlock, just to be sure
$helper->hc('unlock');

// detect multiple monitors
$helper->hc('detect_monitors');

$startup->startPanel();
$startup->startApplications();