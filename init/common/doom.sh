#!/bin/sh
# Install the components of doom emacs

git clone https://github.com/hlissner/doom-emacs ~/.config/emacs
"$HOME/.config/emacs/bin/doom" env
