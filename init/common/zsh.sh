#!/bin/sh
# Creates a cache folder, sets zsh as a default shell and clones oh-my-zsh files

. "$INITDIR/helper.sh"

mkdir -p ~/.cache/zsh
if [ -x "$(command -v usermod)" ] ; then
    sudo usermod --shell "$(which zsh)" "$USER"
else
    change_shell_for_user
fi
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.config/oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
