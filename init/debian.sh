#!/bin/sh

# Start from a base Debian system without any graphical environments, but with git and sudo installed

# Install prompt
echo 'The executed script will install applications on a Debian based system.'
. "${INITDIR}/common/check.sh"

# Create the basic file system
. "${INITDIR}/common/folders.sh"

# Update the system
sudo apt update -yy && sudo apt upgrade -yy --fix-missing

# Add the bullseye-backports repository
echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" | sudo tee /etc/apt/sources.list.d/bullseye-backports.list

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
sudo apt install -yy neofetch stow arandr jq htop tig

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
. "${INITDIR}/common/alacritty.sh"

# Install file manager
sudo apt install -yy vifm

# Install zsh, make it the default shell, and install oh-my-zsh
sudo apt install -yy zsh
. "${INITDIR}/common/zsh.sh"

# Install fonts
sudo apt install -yy fonts-font-awesome
. "${INITDIR}/common/fonts.sh"

# Install the xorg graphical environment
sudo apt install -yy xorg

# Install window manager basics
sudo apt install -yy nitrogen picom dmenu polybar xtrlock i3lock feh lm_sensors

# Install qtile
sudo apt install -yy python3-pip
sudo apt install -yy libxcb-render0-dev
sudo apt install -yy libpangocairo-1.0-0
. "${INITDIR}/common/qtile.sh"

# Install herbstluftwm
sudo apt install -yy herbstluftwm

# Install bspwm
sudo apt install -yy bspwm sxhkd

# Install vim
sudo apt install -yy vim vim-gtk
. "${INITDIR}/common/vim.sh"

# Install dependencies of neovim config
sudo apt install -yy python3-pip nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
. "${INITDIR}/common/neovim-providers.sh"

# Install dependencies of neovim plugins
sudo apt install -yy silversearcher-ag fzf gripgrep fd-find
. "${INITDIR}/common/jdtls.sh"

# Install neovim
sudo apt install -yy neovim
. "${INITDIR}/common/neovim.sh"

# Install emacs module dependencies
# sudo apt install -yy shellcheck # for the sh lang
# sudo apt install -yy markdown # for the markdown lang
# sudo apt install -yy sbcl # for the common-lisp lang
# sudo apt install -yy maim # for the org-mode module
# sudo apt install -yy editorconfig # for editorconfig
# pip3 install isort pipenv pytest nose python-lsp-server # for the python lang
# sudo apt install -yy php-cli php-zip php-curl php-mbstring php-xml # for the php lang
# curl --fail --silent --show-error --location https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer # also for php
# sudo apt install -yy nodejs npm # for the web lang and vue
# sudo apt install -yy node-js-beautify tidy && sudo npm install --global stylelint # for the web lang
# sudo npm install --global vue-language-server # for vue
# sudo apt install -yy ripgrep fd-find

# Install emacs itself - from source, as the Debian library is too old for doom
# EMACS_VERSION=emacs-27.2
# sudo apt install -y \
#     build-essential \
#     texinfo \
#     libx11-dev \
#     libxpm-dev \
#     libjpeg-dev \
#     libpng-dev \
#     libgif-dev \
#     libtiff-dev \
#     libgtk2.0-dev \
#     libncurses-dev \
#     libxpm-dev \
#     automake \
#     autoconf \
#     libgnutls28-dev \
#     libjansson-dev \
#     libxml2-dev
# curl --location https://quantum-mirror.hu/mirrors/pub/gnu/emacs/${EMACS_VERSION}.tar.gz --output ~/Downloads/${EMACS_VERSION}.tar.gz
# cd ~/Downloads
# tar -xvzf ~/Downloads/${EMACS_VERSION}.tar.gz
# rm ~/Downloads/${EMACS_VERSION}.tar.gz
# cd ~/Downloads/${EMACS_VERSION}
# ./configure --with-json
# make
# sudo make install
# cd ~
# rm -rf ~/Downloads/${EMACS_VERSION}

# Install doom
# . "${INITDIR}/common/doom.sh"
# If the command below doesn't work, run Alt-X all-the-icons-install-fonts
# emacs --batch -f all-the-icons-install-fonts
# According to henrik, the above runs emacs without doom, so it doesn't know what all-the-icons are. Hopefully this will work:
# emacs --eval '(all-the-icons-install-fonts t)'

# Install Postman
# . "${INITDIR}/common/postman.sh"

# Install image manipulation program
sudo apt install -yy imagemagick #gimp

# Set up firewall
sudo apt install -yy ufw
sudo systemctl enable ufw.service --now
. "${INITDIR}/common/ufw.sh"

# Install browser
sudo apt install -yy firefox-esr

# Install multimedia
sudo apt install -yy  alsa-utils pulsemixer mpv

# Install Docker and Docker-Compose
sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl --fail --silent --show-error --location https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb http://download.docker.com/linux/debian $(lsb_release --codename --short) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update -yy
sudo apt install -yy docker-ce docker-ce-cli containerd.io

. "${INITDIR}/common/docker-compose.sh"

sudo groupadd docker
sudo usermod -aG docker $USER

# Install Virtualbox
# curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor -o /usr/share/keyrings/virtualbox-keyring.gpg
# echo "deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox-keyring.gpg] https://download.virtualbox.org/virtualbox/debian bullseye contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
# sudo apt update && sudo apt install -y virtualbox-6.1

# Install Virt-Manager
# sudo apt-get install -y qemu qemu-kvm qemu-system qemu-utils
# sudo apt-get install -y virtinst libvirt-clients libvirt-daemon-system
# sudo systemctl start libvirtd
# sudo virsh net-start default
# sudo virsh net-autostart default
# sudo apt-get install -y virt-manager
# sudo usermod -G libvirt -a $USER
# sudo /etc/init.d/networking restart

# Install Dosbox
sudo apt install -y dosbox

# Install password manager
. "${INITDIR}/common/bitwarden.sh"

# Get wallpapers
. "${INITDIR}/common/wallpaper.sh"

# Copy dotfiles
. "${INITDIR}/common/dotfiles.sh"

# Run dotfile-related installs
. "${INITDIR}/common/editor-installs.sh"

# https://www.youtube.com/watch?v=EzqgJhu-qN8
echo '
# Samba fileshare of synology nas
# //192.168.10.49/Media  /media/smb/  cifs  guest,iocharset=utf8,file_mode=0777,dir_mode=0777,credentials=/home/daniel/.config/samba/credentials
' | sudo tee -a /etc/fstab

# Install complete
. "${INITDIR}/common/restart.sh"
