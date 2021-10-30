#!/usr/bin/env bash

# Start from a base Arch install with your user already created, sudo and git installed

# Install prompt
echo 'The executed script will install applications on an Arch based system.'
source ./common/check.sh

# Create the basic file system
source ./common/folders.sh

# Update the system
sudo pacman --sync --refresh --sysupgrade

# Install ssh
sudo pacman -S --noconfirm openssh

# Install network-based tools
sudo pacman -S --noconfirm curl wget

# Install command-line tools
sudo pacman -S --noconfirm neofetch stow arandr xtrlock jq htop tig

# Install build tools
sudo pacman -S --noconfirm base-devel

# Install the yay aur-manager
git clone https://aur.archlinux.org/yay-git.git ~/Downloads
cd yay-git
makepkg --syncdeps --install --noconfirm
cd ~
rm -rf ~/Downloads/yay-git

# Install terminals
sudo pacman -S --noconfirm rxvt-unicode alacritty

# Install file manager
sudo pacman -S --noconfirm vifm

# Install shell and set it as default for user
sudo pacman -S --noconfirm zsh
mkdir -p ~/.cache/zsh
sudo usermod --shell $(which zsh) $USER

# Install oh-my-zsh
source ./common/oh-my-zsh.sh

# Install neovim
sudo pacman -S --noconfirm neovim
source ./common/neovim.sh

# Install the xorg graphical environment
sudo pacman -S --noconfirm xf86-video-fbdev xorg xorg-xinit

# Install fonts
sudo pacman -S --noconfirm ttf-ubuntu-font-family ttf-dejavu ttf-font-awesome
sudo yay -S --noconfirm powerline-fonts-git

# Set up firewall
sudo pacman -S --noconfirm ufw
sudo systemctl enable ufw.service --now
sudo ufw enable
sudo ufw allow Transmission
sudo ufw limit SSH

# Install vim plugin manager and plugins
source ./common/vim.sh

# Install window manager basics
sudo pacman -S --noconfirm nitrogen picom

# Install window manager
sudo pacman -S --noconfirm qtile python-psutil

# Install emacs
sudo pacman -S --noconfirm emacs ripgrep fd
git clone https://github.com/hlissner/doom-emacs ~/.config/emacs
~/.config/emacs/bin/doom install

# Install postman
source ./common/postman.sh

# Install docker and docker-compose
sudo pacman -S --noconfirm docker
source ./common/docker-compose.sh
sudo groupadd docker
sudo usermod -aG docker $USER

# Install browser
sudo pacman -S --noconfirm firefox
source ./common/firefox.sh

# Install multimedia
sudo pacman -S --noconfirm mpv alsa-utils

# Get wallpapers
source ./common/wallpaper.sh

# Install Postman
source ./common/postman.sh

# Copy dotfiles
../stowrestore

# Run dotfile-related installs
doom sync
vim +PluginInstall +qall
nvim +PlugInstall +qall

# Install complete
echo "Software installation complete. Please type in your password, then reboot the computer."
