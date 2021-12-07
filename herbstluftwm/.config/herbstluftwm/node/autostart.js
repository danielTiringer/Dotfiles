#!/usr/bin/env node

'use strict';

const pwd = __dirname;

const colors = require('./color');
const { tags, config } = require('./config');
const { hc, configure } = require('./helper');

configure(config);
