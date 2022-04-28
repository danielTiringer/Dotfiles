#!/bin/sh

# Start from a base Void (glibc) installation with git present

# Install prompt
echo 'The executed script will install applications on a Void based system.'
. "$INITDIR/common/check.sh"

# Create the basic file system
. "$INITDIR/common/folders.sh"

# Update the system
update_system

# Install ssh
# install openssh

# Install network-based tools
install curl wget NetworkManager

# Install file system helpers
install cifs-utils

# Install compressors
install tar unzip p7zip

# Install command-line tools
install neofetch stow arandr autorandr jq htop tig xsel
. "$INITDIR/common/tig.sh"

# Install terminals
install rxvt-unicode alacritty kitty

# Install file manager
install vifm

# Install zsh, set it as default for user, install oh-my-zsh
install zsh
. "$INITDIR/common/zsh.sh"

# Install the xorg graphical environment
install xorg

# Install fonts
install font-awesome
. "$INITDIR/common/fonts.sh"

# Install Asian fonts
install noto-fonts-cjk

# Install window manager basics
install nitrogen picom dmenu xtrlock i3lock feh sxhkd rofi xsetroot polybar lm_sensors

# Install qtile
# install qtile python-psutil

# Install herbstluftwm
install herbstluftwm

# Install bspwm
install bspwm

# Install i3
install i3-gaps

# Install vim plugin manager and plugins
install vim
. "$INITDIR/common/vim.sh"

# Install dependencies of neovim config
install python3-pip nodejs yarn
install gcc
. "$INITDIR/common/neovim-providers.sh"

# Install dependencies of neovim plugins
install the_silver_searcher fzf ripgrep fd
. "$INITDIR/common/jdtls.sh"

# Install neovim
install neovim
. "$INITDIR/common/neovim.sh"

# Install API tester
. "$INITDIR/common/insomnia.sh"
# . "$INITDIR/common/postman.sh"

# Set up firewall
install ufw
sudo xbps-reconfigure ufw
enable_service ufw
. "$INITDIR/common/ufw.sh"

# Install docker and docker-compose
install docker
. "$INITDIR/common/docker-compose.sh"
sudo groupadd docker
sudo usermod -aG docker "$USER"
enable_service docker

# Install configuration management tool
pip install --user ansible
. "$INITDIR/common/hashicorp.sh"
install packer
install terraform

# Install browser
install firefox

# Install multimedia
install mpv alsa-utils

# Enable services for network management, and allow user to make changes to it
enable_service dbus
enable_service NetworkManager
sudo sv up NetworkManager
sudo usermod -aG network "$USER"

# Install password manager
. "$INITDIR/common/bitwarden.sh"

# Get wallpapers
. "$INITDIR/common/wallpaper.sh"

# Copy dotfiles
. "$INITDIR/common/dotfiles.sh"

# Run dotfile-related installs
. "$INITDIR/common/editor-installs.sh"

# Install complete
. "$INITDIR/common/restart.sh"
