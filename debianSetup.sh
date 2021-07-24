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

# Import helper
source helper.sh

# Create the basic file system
cd ~
mkdir Downloads Pictures Documents Projects .config
sudo mkdir -p /media/{2TBDrive,EnglishMedia,ForeignMedia,SDCard,USB,decrypted}
cd ~

# Update the system
sudo apt update -yy
sudo apt upgrade -yy --fix-missing
sleep 5

# Install basic tools for file management
sudo apt install -yy curl wget gdebi thefuck openssh-server jq unzip unrar ntfs-3g stow xclip libclipboard-perl
# Install exfat utilities for managing exfat architecture (SD cards)
sudo apt install -yy exfat-fuse exfat-utils
# Install cryptsetup for encrypted drive operations
sudo apt install -yy cryptsetup
sleep 5

# Install command line tools
sudo apt install -yy zsh neofetch rxvt-unicode figlet bc apt-show-versions
sleep 5

# Install window manager basics
sudo apt install -yy nitrogen compton fonts-font-awesome
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

# Install Asian fonts
sudo apt install -yy fonts-alee fonts-noto-cjk

# Install multimedia
sudo apt install -yy mpv

# Create folder structure for Transmission
mkdir -p ~/Downloads/transmission

# Install Oh-My-Zsh
cd ~/Downloads
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.config/oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
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
pip3 install isort pipenv pytest nose 'python-language-server[all]' # for the python lang
sudo apt install -yy php-cli php-zip php-curl php-mbstring php-xml # for the php lang
curl --fail --silent --show-error --location https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer # also for php
sudo apt install -yy node-js-beautify # for the web lang
sudo apt install -yy ripgrep fd-find

# Install emacs itself - from source, as the Debian library is too old for doom
EMACS_VERSION=emacs-27.2
sudo apt install -y build-essential texinfo libx11-dev libxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev libxpm-dev automake autoconf libgnutls28-dev
wget -P ~/Downloads/ https://quantum-mirror.hu/mirrors/pub/gnu/emacs/${EMACS_VERSION}.tar.gz
cd ~/Downloads
tar -xvzf ~/Downloads/${EMACS_VERSION}.tar.gz
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
emacs --batch -f all-the-icons-install-fonts
sleep 5

# Get wallpapers
wget https://img.wallpapersafari.com/desktop/1920/1080/97/43/JA7EhV.jpg -O ~/Pictures/blueMountains.jpg
wget https://cdn.allwallpaper.in/wallpapers/1920x1080/9024/gorgeous-desert-mountain-oasis-1920x1080-wallpaper.jpg -O ~/Pictures/desertOasis.jpg
wget https://i.imgur.com/sNxf34y.jpg -O ~/Pictures/oceanCoast.jpg
wget http://eskipaper.com/images/stunning-landscape-wallpaper-3.jpg -O ~/Pictures/icyRiver.jpg
wget http://getwallpapers.com/wallpaper/full/d/1/2/990314-beautiful-nature-wallpaper-hd-2600x1728-ios.jpg -O ~/Pictures/autumnTrees.jpg
wget https://cdn.wallpapersafari.com/29/49/hN4mc2.jpg -O ~/Pictures/mountainRiver.jpg
wget https://www.tokkoro.com/picsup/2982099-dark-debian-lenovo-blue___mixed-wallpapers.jpg -O ~/Pictures/debianLenovo.jpg
wget https://www.wallpapermaiden.com/wallpaper/1432/download/1920x1080/linux-cli-commands.jpg -O ~/Pictures/commandLine.jpg
wget http://getwallpapers.com/wallpaper/full/0/5/b/633941.jpg -O ~/Pictures/sundown.jpg
sleep 5

# Install Firefox
sudo apt install -yy firefox-esr
wget -P ~/Downloads https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/user.js
sleep 5

# Install Brave
sudo apt install -yy apt-transport-https
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ trusty main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-trusty.list
sudo apt update -qq
sudo apt install -yy brave-browser
sleep 5

# Install Docker and Docker-Compose
SYSTEM_TYPE=$(uname -s)
SYSTEM_ARCH=$(uname -m)
COMPOSE_VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
COMPOSE_LOCATION=/usr/local/bin/docker-compose
sudo sh -c "$(curl -fsSL https://get.docker.com)"
sudo curl -L --fail https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-${SYSTEM_TYPE}-${SYSTEM_ARCH} -o $COMPOSE_LOCATION
sudo chmod +x $COMPOSE_LOCATION
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
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt install -y software-properties-common
sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
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
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
doom sync
vim +PluginInstall +qall
cd ~
sleep 5

echo '
# 2TB drive, labeled 2TB External
UUID=F474B7AA74B76DCC	/media/2TBDrive	ntfs	defaults	0	0
# 4TB English Media, labeled Elements
UUID=E20EA0710EA04101	/media/EnglishMedia	ntfs	defaults	0	0
# 4TB Foreign Media, labeled 4TB External
UUID=C280DD8C80DD8777	/media/ForeignMedia	ntfs	defaults	0	0
' | sudo tee -a /etc/fstab
sleep 5

# Configure X server
sudo dpkg-reconfigure keyboard-configuration
sudo chmod u+s /usr/bin/xinit

# Update the system from Buster to Bullseye
# sudo sed -i 's/debian-security buster/debian-security bullseye-security/g' /etc/apt/sources.list
# sudo sed -i 's/buster/bullseye/g' /etc/apt/sources.list
# sudo echo 'deb http://deb.debian.org/debian buster-backports main' | sudo tee -a /etc/apt/sources.list
# echo 'Updated the system from buster to bullseye.'
# sleep 5

# Install complete
echo "Software installation complete. Please reboot the computer."
