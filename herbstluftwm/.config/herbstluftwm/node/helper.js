#!/usr/bin/env node
'use strict';

const exec = require('child_process').exec;

function hc(command) {
    exec(`herbstclient ${command}`, (error, stdout, stderr) => {
        if (error) {
            console.error(`exec error: ${error}`);
            return;
        }
        // console.log(`stdout: ${stdout}`);
        // console.error(`stderr: ${stderr}`);
    });
}

function configure(settings) {
    for (const command in settings) {
        for (const key in settings[command]) {
            hc(`${command} ${key} ${settings[command][key]}`);
        }
    }
}

module.exports = { hc, configure };
