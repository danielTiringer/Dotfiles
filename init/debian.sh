#!/bin/sh

# Start from a base Debian system without any graphical environments, but with git and sudo installed

# Install prompt
echo 'The executed script will install applications on a Debian based system.'
. "$INITDIR/common/check.sh"

# Create the basic file system
. "$INITDIR/common/folders.sh"

# Update the system
sudo apt update -yy && sudo apt upgrade -yy --fix-missing

# Add the bullseye-backports repository
echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" | sudo tee /etc/apt/sources.list.d/bullseye-backports.list

# Enable the unstable (sid) repository
echo 'deb http://deb.debian.org/debian/ unstable main contrib non-free' | sudo tee /etc/apt/sources.list.d/unstable.list
echo 'Package: *
Pin: release a=stable
Pin-Priority: 900

Package: *
Pin: release a=unstable
Pin-Priority: 10' | sudo tee /etc/apt/preferences.d/99pin-unstable

# Install ssh
sudo apt install -yy openssh-server

# Install network-based tools
sudo apt install -yy curl wget network-manager

# Install file system helpers
sudo apt install -yy nfs-common
sudo apt install -yy cifs-utils # For smb
sudo apt install -yy exfat-fuse exfat-utils # For FAT32 SD cards
sudo apt install -yy cryptsetup # For encrypted drives
sudo apt install -yy ntfs-3g # For NTFS based external drives

# Install basic tools for file management
sudo apt install -yy unzip unrar-free p7zip-full xclip libclipboard-perl

# Install command line tools
sudo apt install -yy neofetch stow arandr autorandr jq htop tig

# Install Debian-related tools
sudo apt install -yy apt-show-versions gdebi
sudo apt install -yy cron-apt
echo 'OPTIONS="-o quiet=2"
MAILON="NEVER"
DEBUG="verbose"' | sudo tee -a /etc/cron-apt/config

# Install build tools
sudo apt install -yy bc

# Install terminals
sudo apt install -yy rxvt-unicode
sudo apt install -yy cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
. "$INITDIR/common/alacritty.sh"

# Install file manager
sudo apt install -yy vifm

# Install zsh, make it the default shell, and install oh-my-zsh
sudo apt install -yy zsh
. "$INITDIR/common/zsh.sh"

# Install the xorg graphical environment
sudo apt install -yy xorg

# Install fonts
sudo apt install -yy fonts-font-awesome
. "$INITDIR/common/fonts.sh"

# Install window manager basics
sudo apt install -yy nitrogen picom dmenu polybar xtrlock i3lock feh sxhkd lm-sensors rofi

# Install qtile
sudo apt install -yy python3-pip
sudo apt install -yy libxcb-render0-dev
sudo apt install -yy libpangocairo-1.0-0
. "$INITDIR/common/qtile.sh"

# Install herbstluftwm
sudo apt install -yy herbstluftwm

# Install bspwm
sudo apt install -yy bspwm

# Install i3
sudo apt install -yy i3-wm

# Install vim
sudo apt install -yy vim vim-gtk
. "$INITDIR/common/vim.sh"

# Install dependencies of neovim config
sudo apt install -yy python3-pip nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
. "$INITDIR/common/neovim-providers.sh"

# Install dependencies of neovim plugins
sudo apt install -yy silversearcher-ag fzf gripgrep fd-find
. "$INITDIR/common/jdtls.sh"

# Install neovim
sudo apt install -yy -t unstable neovim
. "$INITDIR/common/neovim.sh"

# Install API tester
sudo apt install -yy httpie
# . "$INITDIR/common/postman.sh"

# Set up firewall
sudo apt install -yy ufw
sudo systemctl enable ufw.service --now
. "$INITDIR/common/ufw.sh"

# Install docker and docker-compose
sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl --fail --silent --show-error --location https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb http://download.docker.com/linux/debian $(lsb_release --codename --short) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update -yy
sudo apt install -yy docker-ce docker-ce-cli containerd.io

. "$INITDIR/common/docker-compose.sh"
sudo groupadd docker
sudo usermod -aG docker "$USER"

# Install browser
sudo apt update -yy && sudo apt install -yy -t unstable firefox

# Install multimedia
sudo apt install -yy  alsa-utils pulsemixer mpv

# Install password manager
. "$INITDIR/common/bitwarden.sh"

# Get wallpapers
. "$INITDIR/common/wallpaper.sh"

# Copy dotfiles
. "$INITDIR/common/dotfiles.sh"

# Run dotfile-related installs
. "$INITDIR/common/editor-installs.sh"

# Check if the hardware is a macbook, then install specific stuff
if [ "$(hardware_type)" = 'MacBook' ] ; then
	sudo apt install -yy mbpfan
	. "$INITDIR/specific/macbook-fan.sh"
	. "$INITDIR/specific/macbook-keyboard-brightness.sh"
fi

# Install complete
. "$INITDIR/common/restart.sh"
