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

# Install compressors
sudo dnf install -y tar

# Install command-line tools
sudo dnf install -y neofetch stow arandr jq htop tig xsel lm_sensors

# Install build tools
sudo dnf install -y gcc

# Install terminals
sudo dnf install -y rxvt-unicode alacritty kitty

# Install file manager
sudo dnf install -y vifm

# Install zsh, set it as default for user, install oh-my-zsh
sudo dnf install -y zsh
. "${INITDIR}/common/zsh.sh"

# Install the xorg graphical environment
sudo dnf groupinstall -y "Basic Desktop"

# Install fonts
sudo dnf install -y fontawesome5-fonts-all
. "${INITDIR}/common/fonts.sh"

# Install window manager basics
sudo dnf install -y nitrogen picom dmenu polybar i3lock feh

curl https://raw.githubusercontent.com/rpmsphere/noarch/master/r/rpmsphere-release-34-2.noarch.rpm --output ~/Downloads/rpmsphere.rpm
sudo rpm -Uvh ~/Downloads/rpmsphere.rpm
rm ~/Downloads/rpmsphere.rpm
sudo dnf install -y xtrlock

# Install qtile
sudo dnf install -y python3-pip pango
. "${INITDIR}/common/qtile.sh"

# Install herbstluftwm
sudo dnf install -y herbstluftwm

# Install bspwm
sudo dnf install -y bspwm sxhkd

# Install vim plugin manager and plugins
sudo dnf install -y vim
. "${INITDIR}/common/vim.sh"

# Install dependencies of neovim config
sudo dnf install -y nodejs yarnpkg python-pip
. "${INITDIR}/common/neovim-providers.sh"

# Install dependencies of neovim plugins
sudo dnf install -y the_silver_searcher fzf ripgrep fd-find ctags
. "${INITDIR}/common/jdtls.sh"

# Install neovim
sudo dnf install -y neovim
. "${INITDIR}/common/neovim.sh"

# Install postman
. "${INITDIR}/common/postman.sh"

# Set up firewall
sudo dnf install -y ufw
sudo systemctl enable ufw.service --now
. "${INITDIR}/common/ufw.sh"

# Install docker and docker-compose
sudo dnf install -y docker
. "${INITDIR}/common/docker-compose.sh"
sudo groupadd docker
sudo usermod -aG docker $USER

# Install browser
sudo dnf install -y firefox

# Install multimedia
sudo dnf install -y mpv alsa-utils

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
