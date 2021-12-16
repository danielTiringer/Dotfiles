#!/bin/sh
# Installing neovim providers

sudo npm install --cache $HOME/.cache/npm/ --global neovim
python3 -m pip install --user --upgrade pynvim
