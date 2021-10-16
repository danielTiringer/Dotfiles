#!/bin/bash

# Daniel Tiringer's install script for Debian based distributions.
#      _      _     _
#   __| | ___| |__ (_) __ _ _ __
#  / _` |/ _ \ '_ \| |/ _` | '_ \
# | (_| |  __/ |_) | | (_| | | | |
#  \__,_|\___|_.__/|_|\__,_|_| |_|

# Install prompt
echo 'The executed script will install applications on a Debian based system.'
while true
do
    read -r -p 'Are you sure you want to proceed? [Y/n] ' input
    case $input in
        [Yy][Ee][Ss]|[Yy]) echo 'Please enter your password:'; sleep 1; break;;
        [Nn][Oo]|[Nn]) echo 'User aborted.'; exit 1;;
        * ) echo 'Please answer yes or no.';;
    esac
done

# Create the basic file system
source ./common/folders.sh

# Update the system
sudo apt update -yy
sudo apt upgrade -yy --fix-missing
sleep 5

# Install basic tools for file management
sudo apt install -yy curl wget gdebi openssh-server jq unzip unrar p7zip-full p7zip-rar ntfs-3g stow xclip libclipboard-perl
# Install exfat utilities for managing exfat architecture (SD cards)
sudo apt install -yy exfat-fuse exfat-utils
# Install nfs-common
sudo apt install -yy nfs-common
# Install cifs-utils for mounting smb shares
sudo apt install -yy cifs-utils
# Install cryptsetup for encrypted drive operations
sudo apt install -yy cryptsetup
sleep 5

# Install command line tools
sudo apt install -yy zsh neofetch rxvt-unicode figlet bc apt-show-versions
sleep 5

# Install window manager basics
sudo apt install -yy nitrogen picom fonts-font-awesome
sleep 5

# Install qtile
sudo apt install -yy python3-pip
sudo apt install -yy libxcb-render0-dev
sudo apt install -yy libpangocairo-1.0-0
pip3 install xcffib psutil dbus-next
pip3 install --no-cache-dir cairocffi

git clone git://github.com/qtile/qtile.git ~/Downloads/qtile
pip3 install ~/Downloads/qtile/
rm -rf ~/Downloads/qtile

sudo echo '[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec=qtile start
Type=Application
Keywords=wm;tiling' | sudo tee /usr/share/xsessions/qtile.desktop
sleep 5

# Install utilities
sudo apt install -yy network-manager alsa-utils xbacklight xorg xtrlock lm-sensors pulsemixer
sleep 5

# Install cron-apt
sudo apt install -yy cron-apt
echo 'OPTIONS="-o quiet=2"
MAILON="NEVER"
DEBUG="verbose"' | sudo tee -a /etc/cron-apt/config
sleep 5

# Install image manipulation program
sudo apt install -yy imagemagick #gimp
sleep 5

# Install multimedia
sudo apt install -yy mpv

# Create folder structure for Transmission
mkdir -p ~/Downloads/transmission

# Install Oh-My-Zsh
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

source ./common/oh-my-zsh.sh
cd ~

mkdir -p ~/.cache/zsh
sudo usermod --shell $(which zsh) $USER
sleep 5

# Set up firewall
sudo apt install -yy ufw
sudo systemctl enable ufw.service --now
sudo ufw enable
sudo ufw allow Transmission
sudo ufw limit SSH
sudo ufw limit OpenSSH
sleep 5

# Install Vim
sudo apt install -yy vim vim-gtk vifm
sleep 5

# Install emacs module dependencies
sudo apt install -yy shellcheck # for the sh lang
sudo apt install -yy markdown # for the markdown lang
sudo apt install -yy sbcl # for the common-lisp lang
sudo apt install -yy maim # for the org-mode module
sudo apt install -yy editorconfig # for editorconfig
pip3 install isort pipenv pytest nose python-lsp-server # for the python lang
sudo apt install -yy php-cli php-zip php-curl php-mbstring php-xml # for the php lang
curl --fail --silent --show-error --location https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer # also for php
sudo apt install -yy nodejs npm # for the web lang and vue
sudo apt install -yy node-js-beautify tidy && sudo npm install --global styleline # for the web lang
sudo npm install --global vue-language-server # for vue
sudo apt install -yy ripgrep fd-find

# Install emacs itself - from source, as the Debian library is too old for doom
EMACS_VERSION=emacs-27.2
sudo apt install -y build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev libxpm-dev automake autoconf libgnutls28-dev libjansson4
wget -P ~/Downloads/ https://quantum-mirror.hu/mirrors/pub/gnu/emacs/${EMACS_VERSION}.tar.gz
cd ~/Downloads
tar -xvzf ~/Downloads/${EMACS_VERSION}.tar.gz
rm ~/Downloads/${EMACS_VERSION}.tar.gz
cd ~/Downloads/${EMACS_VERSION}
./configure
make
sudo make install
cd ~
rm -rf ~/Downloads/${EMACS_VERSION}

# Install doom
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
PATH="$HOME/.emacs.d/bin:$PATH"
mkdir -p ~/.emacs.d/.local/straight/repos
git clone -b develop https://github.com/raxod502/straight.el ~/.emacs.d/.local/straight/repos/straight.el
doom env
# If the command below doesn't work, run Alt-X all-the-icons-install-fonts
emacs --batch -f all-the-icons-install-fonts
# According to henrik, the above runs emacs without doom, so it doesn't know what all-the-icons are. Hopefully this will work:
emacs --eval '(all-the-icons-install-fonts t)'
sleep 5

# Get wallpapers
source ./common/wallpaper.sh

# Install Firefox
sudo apt install -yy firefox-esr
source ./common/firefox.sh
sleep 5

# Install Brave
sudo apt install -yy apt-transport-https
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ trusty main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-trusty.list
sudo apt update -qq
sudo apt install -yy brave-browser
sleep 5

# Install Docker and Docker-Compose
sudo sh -c "$(curl -fsSL https://get.docker.com)"
source ./common/docker-compose.sh
sudo groupadd docker
sudo usermod -aG docker $USER
sleep 5

# Install Postman
cd ~/Downloads
wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
sudo tar -xvzf postman-linux-x64.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
rm postman-linux-x64.tar.gz
cd ~
sleep 5

# Install Virtualbox
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor -o /usr/share/keyrings/virtualbox-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/virtualbox-keyring.gpg] https://download.virtualbox.org/virtualbox/debian bullseye contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
sudo apt update && sudo apt install -y virtualbox-6.1
sleep 5

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
sleep 5

# Install Anki
cd ~/Downloads/
wget https://github.com/ankitects/anki/releases/download/2.1.37/anki-2.1.37-linux.tar.bz2
tar xjf Downloads/anki-2.1.37-linux.tar.bz2
cd anki-2.1.37-linux
sudo ./install.sh
cd ~
rm -rf ~/Downloads/anki-2.1.37-linux.tar.bz2
rm -rf ~/Downloads/anki-2.1.37-linux
sleep 5

# Setup the dotfiles and configs
rm ~/.bashrc ~/.gitconfig ~/.vimrc ~/.zshrc ~/.Xresources ~/.ssh/config
rm -r ~/.config/compton ~/.config/nitrogen
cd ~/Dotfiles
./stowrestore
source ./common/vim.sh
doom sync
vim +PluginInstall +qall
cd ~
sleep 5

# https://www.youtube.com/watch?v=EzqgJhu-qN8
echo '
# Samba fileshare of synology nas
//192.168.10.49/Media  /media/smb/  cifs  guest,iocharset=utf8,file_mode=0777,dir_mode=0777,credentials=/home/daniel/.config/samba/credentials
' | sudo tee -a /etc/fstab
sleep 5

# Configure X server
sudo dpkg-reconfigure keyboard-configuration
sudo chmod u+s /usr/bin/xinit

# Install complete
echo "Software installation complete. Please reboot the computer."
