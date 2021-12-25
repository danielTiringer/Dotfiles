#!/bin/sh

# Start from a base Void (glibc) installation with git present

# Install prompt
echo 'The executed script will install applications on a Void based system.'
. "${INITDIR}/common/check.sh"

# Create the basic file system
. "${INITDIR}/common/folders.sh"

# Update the system
sudo xbps-install --sync --yes --update

# Install ssh
# sudo xbps-install -S --yes openssh

# Install network-based tools
sudo xbps-install -S --yes curl wget NetworkManager

# Install file system helpers
sudo xbps-install -S --yes cifs-utils

# Install compressors
sudo xbps-install -S --yes tar unzip p7zip

# Install command-line tools
sudo xbps-install -S --yes neofetch stow arandr autorandr jq htop tig xsel

# Install terminals
sudo xbps-install -S --yes rxvt-unicode alacritty kitty

# Install file manager
sudo xbps-install -S --yes vifm

# Install zsh, set it as default for user, install oh-my-zsh
sudo xbps-install -S --yes zsh
. "${INITDIR}/common/zsh.sh"

# Install the xorg graphical environment
sudo xbps-install -S --yes xorg

# Install fonts
sudo xbps-install -S --yes font-awesome
. "${INITDIR}/common/fonts.sh"

# Install Asian fonts
sudo xbps-install -S --yes noto-fonts-cjk

# Install window manager basics
sudo xbps-install -S --yes nitrogen picom dmenu xtrlock i3lock feh sxhkd rofi xsetroot polybar lm_sensors
yay -S --yes polybar

# Install qtile
# sudo xbps-install -S --yes qtile python-psutil

# Install herbstluftwm
sudo xbps-install -S --yes herbstluftwm

# Install bspwm
sudo xbps-install -S --yes bspwm

# Install i3
sudo xbps-install -S --yes i3-gaps

# Install vim plugin manager and plugins
sudo xbps-install -S --yes vim
. "${INITDIR}/common/vim.sh"

# Install dependencies of neovim config
sudo xbps-install -S --yes python3-pip nodejs yarn
sudo xbps-install -S --yes gcc
. "${INITDIR}/common/neovim-providers.sh"

# Install dependencies of neovim plugins
sudo xbps-install -S --yes the_silver_searcher fzf ripgrep fd
. "${INITDIR}/common/jdtls.sh"

# Install neovim
sudo xbps-install -S --yes neovim
. "${INITDIR}/common/neovim.sh"

# Install API tester
sudo xbps-install -S --yes httpie
. "${INITDIR}/common/postman.sh"

# Set up firewall
sudo xbps-install -S --yes ufw
sudo xbps-reconfigure ufw
sudo ln -s /etc/sv/ufw /var/service
. "${INITDIR}/common/ufw.sh"

# Install docker and docker-compose
sudo xbps-install -S --yes docker
. "${INITDIR}/common/docker-compose.sh"
sudo groupadd docker
sudo usermod -aG docker "$USER"
sudo ln -s /etc/sv/docker /var/service

# Install browser
sudo xbps-install -S --yes firefox

# Install multimedia
sudo xbps-install -S --yes mpv alsa-utils

# Enable services for network management, and allow user to make changes to it
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/NetworkManager /var/service
sudo sv up NetworkManager
sudo usermod -aG network "$USER"

# Install password manager
. "${INITDIR}/common/bitwarden.sh"

# Get wallpapers
. "${INITDIR}/common/wallpaper.sh"

# Copy dotfiles
. "${INITDIR}/common/dotfiles.sh"

# Run dotfile-related installs
. "${INITDIR}/common/editor-installs.sh"

# Install complete
. "${INITDIR}/common/restart.sh"
