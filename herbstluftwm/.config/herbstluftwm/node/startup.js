#!/usr/bin/env node
'use strict';

const { exec } = require('child_process');
const colors = require('./color');

function setBackground() {
    exec(`xsetroot -solid "${colors.purple}"`);
}

function startPanel() {
    exec(`${process.env.XDG_CONFIG_HOME}/polybar/launch.sh mainbar-herbst &`);
}

function startApplications() {
    exec('picom &');
    exec(`feh --no-fehbg --bg-center "${process.env.HOME}/Pictures/dark-leaves.jpg" &`);
    exec(`sxhkd -c ${process.env.XDG_CONFIG_HOME}/sxhkd/common_sxhkdrc &`);
}

module.exports = { setBackground, startPanel, startApplications };
