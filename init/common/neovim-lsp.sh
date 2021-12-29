#!/bin/sh
# Install language servers used by neovim

sudo npm install --cache "$HOME"/.cache/npm/ --global neovim
sudo npm install --cache "$HOME"/.cache/npm/ --global typescript typescript-language-server
sudo npm install --cache "$HOME"/.cache/npm/ --global pyright
sudo npm install --cache "$HOME"/.cache/npm/ --global bash-language-server
