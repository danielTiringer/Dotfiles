#!/bin/sh
# Distributes dotfiles

cd "$DOTFILEDIR"
./stowrestore.sh

# Clone standalone repository that is used by zsh
git clone git@github.com:danielTiringer/Bitwarden-Wrapper.git "$HOME"/.config/zsh/scripts/Bitwarden-Wrapper
