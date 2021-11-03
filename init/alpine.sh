#!/bin/sh

# Install script for Alpine based distributions.

# Get the base (extended) image from here after updating the version number:
# wget http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-extended-3.12.0-x86_64.iso

# Set up the wireless network using wpa_supplicant and wireless-tools:
# https://wiki.alpinelinux.org/wiki/Connecting_to_a_wireless_access_point

echo 'The executed script will install applications on an Alpine based system.'
. "${INITDIR}/common/check.sh"

# Create the basic file system
. "${INITDIR}/common/folders.sh"

# Enable extra repositories
sed -i '2,6s/#//g' /etc/apk/repositories

# Update the system
apk update
apk upgrade

# Install ZSH and Oh-My-Zsh
apk add zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Change default shell to latest added user
sed -i '$s/ash/zsh/' /etc/passwd

# Install Window Manager
setup-xorg-base
apk add herbstluftwm compton nitrogen rxvt-unicode

# Install utilities
apk add stow neofetch curl wget

# Get wallpapers
. "${INITDIR}/common/wallpaper.sh"

# Install Postman
# . "${INITDIR}/common/postman.sh"

# Setup the dotfiles and configs
cd ~/Dotfiles
./stowrestore
sudo cp -r ~/.config/polybar/fonts/* /usr/share/fonts
sudo fc-cache -vf /usr/share/fonts
doom sync
vim +PluginInstall +qall
cd ~

# Install complete
echo "Software installation complete. Please type in your password, then reboot the computer."

# Change shell
chsh -s $(which zsh)
