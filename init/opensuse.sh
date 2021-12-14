#!/bin/sh

# Start from a base OpenSUSE Server type install with your user already created and git installed

# Install prompt
echo 'The executed script will install applications on an openSUSE based system.'
. "${INITDIR}/common/check.sh"

# Create the basic file system
. "${INITDIR}/common/folders.sh"

# Update the system
sudo zypper update -y

# Install ssh
sudo zypper install -y openssud

# Install network-based tools
sudo zypper install -y curl wget NetworkManager

# Install file system helpers
sudo zypper install -y cifs-utils

# Install compressors
sudo zypper install -y tar unzip unrar p7zip

# Install command-line tools
sudo zypper install -y neofetch stow arandr jq htop tig xsel

# Install terminals
sudo zypper install -y rxvt-unicode alacritty kitty

# Install file manager
sudo zypper install -y vifm

# Install zsh, set it as default for user, install oh-my-zsh
sudo zypper install -y zsh
. "${INITDIR}/common/zsh.sh"

# Install the xorg graphical environment
sudo zypper install -y xorg-x11

# Install fonts
sudo zypper install -y fontawesome-fonts
. "${INITDIR}/common/fonts.sh"

# Install window manager basics
sudo zypper install -y nitrogen picom dmenu polybar i3lock feh sxhkd

# Install qtile
sudo zypper install -y qtile

# Install herbstluftwm
sudo zypper install -y herbstluftwm

# Install bspwm
sudo zypper install -y bspwm

# Install vim plugin manager and plugins
sudo zypper install -y vim
. "${INITDIR}/common/vim.sh"

# Install dependencies of neovim config
sudo zypper -y install python3-pip nodejs-common yarn
. "${INITDIR}/common/neovim-providers.sh"

# Install dependencies of neovim plugins
sudo zypper -y install the_silver_searcher fzf ripgrep fd ctags
. "${INITDIR}/common/jdtls.sh"

# Install neovim
sudo zypper -y install neovim
. "${INITDIR}/common/neovim.sh"

# Install emacs
sudo zypper -y install emacs ripgrep fd
. "${INITDIR}/common/doom.sh"

# Install Postman
. "${INITDIR}/common/postman.sh"

# Set up firewall
sudo zypper addrepo https://download.opensuse.org/repositories/security/openSUSE_Tumbleweed/security.repo
sudo zypper --gpg-auto-import-keys refresh
sudo zypper install ufw
sudo systemctl enable ufw.service --now
. "${INITDIR}/common/ufw.sh"

# Install Docker and Docker-Compose
sudo zypper install -y docker
. "${INITDIR}/common/docker-compose.sh"
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker "$USER"
sudo systemctl restart docker

# Install browser
sudo zypper install -y firefox

# Install multimedia
sudo zypper install -y mpv alsa-utils

# Get wallpapers
. "${INITDIR}/common/wallpaper.sh"

# Copy dotfiles
. "${INITDIR}/common/dotfiles.sh"

# Run dotfile-related installs
. "${INITDIR}/common/editor-installs.sh"

# Install complete
. "${INITDIR}/common/restart.sh"
