#!/bin/sh

# Start from a base Arch install with your user already created, sudo and git installed

# Install prompt
echo 'The executed script will install applications on an Arch based system.'
. "$INITDIR/common/check.sh"

# Create the basic file system
. "$INITDIR/common/folders.sh"

# Update the system
update_system

# Install ssh
install openssh

# Install network-based tools
install curl wget networkmanager

# Install file system helpers
install cifs-utils

# Install compressors
install tar unzip unrar p7zip

# Install command-line tools
install neofetch stow arandr autorandr jq htop tig xsel
. "$INITDIR/common/tig.sh"

# Install build tools
install base-devel

# Install the yay aur-manager
git clone https://aur.archlinux.org/yay-git.git ~/Downloads/yay
cd ~/Downloads/yay
makepkg --syncdeps --install --noconfirm
cd ~
rm -rf ~/Downloads/yay

# Install terminals
install rxvt-unicode alacritty kitty

# Install file manager
install vifm

# Install zsh, set it as default for user, install oh-my-zsh
install zsh
. "$INITDIR/common/zsh.sh"

# Install the xorg graphical environment
install xf86-video-fbdev xorg xorg-xinit

# Install fonts
install ttf-font-awesome
. "$INITDIR/common/fonts.sh"

# Install Asian fonts
install noto-fonts-cjk

# Install window manager basics
install nitrogen picom dmenu xtrlock i3lock feh sxhkd rofi xorg-xsetroot
yay -S --noconfirm polybar

# Install qtile
install qtile python-psutil

# Install herbstluftwm
install herbstluftwm

# Install bspwm
install bspwm

# Install i3
install i3-gaps

# Install vim plugin manager and plugins
. "$INITDIR/common/vim.sh"

# Install dependencies of neovim config
install python-pip nodejs yarn npm
. "$INITDIR/common/neovim-providers.sh"

# Install dependencies of neovim plugins
install the_silver_searcher fzf ripgrep fd
yay -S --noconfirm ctags-git

# Install neovim
install neovim
. "$INITDIR/common/neovim.sh"

# Install phpstorm
yay -S --noconfirm phpstorm phpstorm-jre

# Install intellij
install intellij-idea-community-edition

# Install webstorm
yay -S --noconfirm webstorm webstorm-jre

# Install API tester
# yay -S --noconfirm insomnia
. "$INITDIR/common/postman.sh"

# Install database manager
install dbeaver

# Install VPN client
install openvpn

# Set up firewall
install ufw
enable_service ufw
. "$INITDIR/common/ufw.sh"

# Install docker and docker-compose
install docker
. "$INITDIR/common/docker-compose.sh"
sudo groupadd docker
sudo usermod -aG docker "$USER"
enable_service docker

# Install browser
install firefox
yay -S --noconfirm brave-bin

# Install multimedia
install mpv alsa-utils

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
