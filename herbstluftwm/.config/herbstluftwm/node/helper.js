#!/usr/bin/env node
'use strict';

const { tags } = require('./config');

const { exec } = require('child_process');

function hc(command) {
    exec(`herbstclient ${command}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return;
        }
        if (stdout) {
            console.log(`stdout: ${stdout}`);
        }
        if (stderr) {
            console.error(`stderr: ${stderr}`);
        }
    });
}

function setTagsWithName() {
    hc(`rename default '${tags[1]}' 2>/dev/null || true`);

    for (const key in tags) {
        hc(`add '${tags[key]}'`)

        if (tags[key]) {
            hc(`keybind Mod4-${key} use_index '${key - 1}'`);
            hc(`keybind Mod4-Shift-${key} move_index '${key - 1}'`);
        }
    }
}

function configure(settings) {
    for (const command in settings) {
        for (const key in settings[command]) {
            hc(`${command} ${key} ${settings[command][key]}`);
        }
    }
}

module.exports = { hc, setTagsWithName, configure };
