#!/bin/sh

# Start from a Fedora Custom Operation system base from an Everything alternative image
# Have your user already, with sudo access and git installed

# Install prompt
echo 'The executed script will install applications on an Fedora based system.'
. "${INITDIR}/common/check.sh"

# Create the basic file system
. "${INITDIR}/common/folders.sh"

# Update the system
sudo dnf check-update && sudo dnf -y upgrade

# Enable the RPM-Fusion repository
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# Install network-based tools
sudo dnf install -y curl wget

# Install file system helpers
sudo dnf install -y cifs-utils

# Install command-line tools
sudo dnf install -y neofetch stow arandr jq htop tig xsel

curl https://raw.githubusercontent.com/rpmsphere/noarch/master/r/rpmsphere-release-34-2.noarch.rpm --output ~/Downloads/rpmsphere.rpm
sudo rpm -Uvh ~/Downloads/rpmsphere.rpm
rm ~/Downloads/rpmsphere.rpm
sudo dnf install -y xtrlock

# Install terminals
sudo dnf install -y rxvt-unicode alacritty kitty

# Install file manager
sudo dnf install -y vifm

# Install zsh, set it as default for user, install oh-my-zsh
sudo dnf install -y zsh
. "${INITDIR}/common/zsh.sh"

# Install the xorg graphical environment
sudo dnf install -y xorg-x11-server-Xorg

# Install fonts
sudo dnf install -y powerline-fonts dejavu-fonts-all fontawesome5-fonts-all

# Install window manager basics
sudo dnf install -y nitrogen picom dmenu
