#!/bin/sh

# Install script for Alpine based distributions.

# Get the base (extended) image from here after updating the version number:
# wget http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-extended-3.12.0-x86_64.iso

# The script does not cover user creation, sudo install and assignment of rights.

# Set up the wireless network using wpa_supplicant and wireless-tools:
# https://wiki.alpinelinux.org/wiki/Connecting_to_a_wireless_access_point

echo 'The executed script will install applications on an Alpine based system.'
. "${INITDIR}/common/check.sh"

# Create the basic file system
. "${INITDIR}/common/folders.sh"

# Enable extra repositories
sudo sed -i '2,6s/#//g' /etc/apk/repositories

# Update the system
sudo apk update
sudo apk upgrade

# Install network-based tools
sudo apk add curl

# Install file system helpers
sudo apk add cifs-utils

# Install command line tools
sudo apk add neofetch stow arandr jq htop tig xsel

# Install terminals
sudo apk add rxvt-unicode kitty

# Install alacritty
# sudo apk add cmake pkgconf freetype-dev fontconfig-dev python3 libxcb-dev build-base gcc abuild binutils binutils-doc gcc-doc
# . "${INITDIR}/common/alacritty.sh"

# Install file manager
sudo apk add vifm

# Install ZSH and set is as default for user
sudo apk add zsh zsh-vcs
. "${INITDIR}/common/zsh.sh"

# Install the xorg graphical environment
sudo setup-xorg-base

# Install fonts
sudo apk add ttf-dejavu

# Install Asian fonts
sudo apk add font-noto-cjk

# Install window manager basics
sudo apk add picom dmenu polybar

# Install window manager
sudo apk add herbstluftwm

# Install vim
sudo apk add vim

# Install vim plugin manager and plugins
. "${INITDIR}/common/vim.sh"

# Install neovim
# sudo apk add neovim
# . "${INITDIR}/common/neovim.sh"

# Install emacs
sudo apk add emacs

# Install doom
. "${INITDIR}/common/doom.sh"

# Install Postman
# . "${INITDIR}/common/postman.sh"

# Set up firewall
sudo apk add ip6tables ufw
sudo rc-update add ufw
. "${INITDIR}/common/ufw.sh"

# Install docker and docker-compose
sudo apk add docker
. "${INITDIR}/common/docker-compose.sh"
sudo addgroup $USER docker
sudo rc-update add docker boot
sudo service docker start

# Install browser
sudo apk add firefox

# Install multimedia
sudo apk add mpv alsa-utils

# Get wallpapers
. "${INITDIR}/common/wallpaper.sh"

# Copy dotfiles
. "${INITDIR}/common/dotfiles.sh"

# Run dotfile-related installs
. "${INITDIR}/common/editor-installs.sh"

# Simplify the login message
sudo sed -i -e '2,10d' /etc/motd

# Install complete
. "${INITDIR}/common/restart.sh"
