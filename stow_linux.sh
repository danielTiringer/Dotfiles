#!/bin/sh

echo 'Restoring all the regular config files'
sleep 1

stow -v -R alacritty
stow -v -R bash
stow -v -R bspwm
stow -v -R dosbox
stow -v -R gitdir
cp gnupg/.config/gnupg/gpg.conf ~/.config/gnupg/gpg.conf
stow -v -R herbstluftwm
stow -v -R i3
stow -v -R kitty
stow -v -R npm
stow -v -R nvim
stow -v -R qtile
stow -v -R picom
stow -v -R polybar
stow -v -R rofi
cp ssh/.ssh/config ~/.ssh
stow -v -R sxhkd
stow -v -R tig
stow -v -R urxvt
stow -v -R vifm
stow -v -R vim
stow -v -R wget
stow -v -R xinitrc
stow -v -R xresources
stow -v -R zsh_linux

echo "Restoration complete"
