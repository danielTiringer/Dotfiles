#!/bin/sh

# Start from a base Arch install with your user already created, sudo and git installed

# Install prompt
echo 'The executed script will install applications on an Arch based system.'
. "${INITDIR}/common/check.sh"

# Create the basic file system
. "${INITDIR}/common/folders.sh"

# Update the system
sudo pacman --sync --refresh --sysupgrade --noconfirm

# Install ssh
sudo pacman -S --noconfirm openssh

# Install network-based tools
sudo pacman -S --noconfirm curl wget networkmanager

# Install file system helpers
sudo pacman -S --noconfirm cifs-utils

# Install compressors
sudo pacman -S --noconfirm tar unzip unrar p7zip

# Install command-line tools
sudo pacman -S --noconfirm neofetch stow arandr jq htop tig xsel

# Install build tools
sudo pacman -S --noconfirm base-devel

# Install the yay aur-manager
git clone https://aur.archlinux.org/yay-git.git ~/Downloads/yay
cd ~/Downloads/yay
makepkg --syncdeps --install --noconfirm
cd ~
rm -rf ~/Downloads/yay

# Install terminals
sudo pacman -S --noconfirm rxvt-unicode alacritty kitty

# Install file manager
sudo pacman -S --noconfirm vifm

# Install zsh, set it as default for user, install oh-my-zsh
sudo pacman -S --noconfirm zsh
. "${INITDIR}/common/zsh.sh"

# Install the xorg graphical environment
sudo pacman -S --noconfirm xf86-video-fbdev xorg xorg-xinit

# Install fonts
sudo pacman -S --noconfirm ttf-font-awesome
. "${INITDIR}/common/fonts.sh"

# Install Asian fonts
sudo pacman -S --noconfirm noto-fonts-cjk

# Install window manager basics
sudo pacman -S --noconfirm nitrogen picom dmenu xtrlock i3lock feh sxhkd rofi xorg-xsetroot
yay -S --noconfirm polybar

# Install qtile
sudo pacman -S --noconfirm qtile python-psutil

# Install herbstluftwm
sudo pacman -S --noconfirm herbstluftwm

# Install bspwm
sudo pacman -S --noconfirm bspwm

# Install i3
sudo pacman -S --noconfirm i3-gaps

# Install vim plugin manager and plugins
. "${INITDIR}/common/vim.sh"

# Install dependencies of neovim config
sudo pacman -S --noconfirm python-pip nodejs yarn npm
. "${INITDIR}/common/neovim-providers.sh"

# Install dependencies of neovim plugins
sudo pacman -S --noconfirm the_silver_searcher fzf ripgrep fd
yay -S --noconfirm ctags-git
. "${INITDIR}/common/jdtls.sh"

# Install neovim
sudo pacman -S --noconfirm neovim
. "${INITDIR}/common/neovim.sh"

# Install API tester
sudo pacman -S --noconfirm httpie
# . "${INITDIR}/common/postman.sh"

# Set up firewall
sudo pacman -S --noconfirm ufw
sudo systemctl enable ufw.service --now
. "${INITDIR}/common/ufw.sh"

# Install docker and docker-compose
sudo pacman -S --noconfirm docker
. "${INITDIR}/common/docker-compose.sh"
sudo groupadd docker
sudo usermod -aG docker "$USER"

# Install browser
sudo pacman -S --noconfirm firefox

# Install multimedia
sudo pacman -S --noconfirm mpv alsa-utils

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
