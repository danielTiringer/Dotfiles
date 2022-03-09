#!/bin/sh

# Install script for Alpine based distributions.

# Get the base (extended) image from here after updating the version number:
# wget http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-extended-3.12.0-x86_64.iso

# The script does not cover user creation, sudo install and assignment of rights.

# Set up the wireless network using wpa_supplicant and wireless-tools:
# https://wiki.alpinelinux.org/wiki/Connecting_to_a_wireless_access_point

echo 'The executed script will install applications on an Alpine based system.'
. "$INITDIR/common/check.sh"

# Create the basic file system
. "$INITDIR/common/folders.sh"

# Enable extra repositories
sudo sed --in-place '2,6s/^# //g' /etc/apk/repositories
sudo sed --in-place '2,6s/^#//g' /etc/apk/repositories

# Update the system
update_system

# Install network-based tools
install curl

# Install file system helpers
install cifs-utils

# Install command line tools
install neofetch stow arandr jq htop tig xsel
. "$INITDIR/common/tig.sh"

# Install terminals
install rxvt-unicode kitty

# Install alacritty
# install cmake pkgconf freetype-dev fontconfig-dev python3 libxcb-dev build-base gcc abuild binutils binutils-doc gcc-doc
# . "$INITDIR/common/alacritty.sh"

# Install file manager
install vifm

# Install ZSH and set is as default for user
install zsh zsh-vcs
. "$INITDIR/common/zsh.sh"

# Install the xorg graphical environment
sudo setup-xorg-base

# Install fonts
install ttf-font-awesome
. "$INITDIR/common/fonts.sh"

# Install Asian fonts
install font-noto-cjk

# Install window manager basics
install picom dmenu polybar i3lock feh sxhkd xsetroot

# Install herbstluftwm
install herbstluftwm

# Install bspwm
install bspwm

# Install i3
install i3wm

# Install vim
install vim

# Install vim plugin manager and plugins
. "$INITDIR/common/vim.sh"

# Install neovim
# install neovim
# . "$INITDIR/common/neovim.sh"

# Install doom
# . "$INITDIR/common/doom.sh"

# Install API tester
install httpie
# . "$INITDIR/common/postman.sh"

# Set up firewall
install ip6tables ufw
sudo rc-update add ufw
. "$INITDIR/common/ufw.sh"

# Install docker and docker-compose
install docker
. "$INITDIR/common/docker-compose.sh"
sudo addgroup "$USER" docker
enable_service docker

# Install browser
install firefox

# Install multimedia
install mpv alsa-utils

# Get wallpapers
. "$INITDIR/common/wallpaper.sh"

# Copy dotfiles
. "$INITDIR/common/dotfiles.sh"

# Run dotfile-related installs
. "$INITDIR/common/editor-installs.sh"

# Simplify the login message
sudo sed -i -e '2,10d' /etc/motd

# Install complete
. "$INITDIR/common/restart.sh"
