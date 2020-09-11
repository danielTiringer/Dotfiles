#!/bin/bash

# Daniel Tiringer's install script for Alpine based distributions.

#        _       _
#   __ _| |_ __ (_)_ __   ___
#  / _` | | '_ \| | '_ \ / _ \
# | (_| | | |_) | | | | |  __/
#  \__,_|_| .__/|_|_| |_|\___|
#         |_|

# Get the base (extended) image from here after updating the version number:
# wget http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-extended-3.12.0-x86_64.iso

# Set up the wireless network using wpa_supplicant and wireless-tools:
# https://wiki.alpinelinux.org/wiki/Connecting_to_a_wireless_access_point

echo 'The executed script will install applications on an Alpine based system.'

# Generate a user
if [ $(id -u) -eq 0 ]; then
	echo 'Generate a new user for the system:'
	read -p "Enter username : " username
	read -s -p "Enter password : " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p "$pass" "$username"
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
	fi
else
	echo "Only root may add a user to the system."
	exit 2
fi

user = tail -1 /etc/passwd | cut -f1 -d':'

# Create the basic file system
cd ~
mkdir Downloads Pictures Documents .config
sudo mkdir /media/{2TBDrive,4TBDrive,MemCard,USB}
cd ~
sleep 5

# Enable extra repositories
sed -i '2,6s/#//g' /etc/apk/repositories

# Update the system
apk update
apk upgrade
sleep 5

# Create folder structure for Transmission
mkdir -p ~/Downloads/transmission/{config,downloads,torrents}

# Set up Git
apk add git
git config --global user.email "tiringerdaniel@gmail.com"
git config --global user.name "danielTiringer"
sleep 5

# Generate SSH key for Github
mkdir ~/.ssh
ssh-keygen -t rsa -b 4096 -C "tiringerdaniel@gmail.com" -f ~/.ssh/id_rsa_$(hostname) -q -N ""
sleep 5

# Install ZSH
apk add zsh and Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Change default shell to latest added user
sed -i '$s/ash/zsh/' /etc/passwd

# Install Window Manager
setup-xorg-base
apk add herbstluftwm compton nitrogen rxvt-unicode

# Install utilities
apk add stow neofetch curl wget

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

# Make project directories
mkdir ~/Projects

# Install Postman
# cd ~/Downloads
# wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
# sudo tar -xvzf postman-linux-x64.tar.gz -C /opt
# sudo ln -s /opt/Postman/Postman /usr/bin/postman
# rm postman-linux-x64.tar.gz
# cd ~
# sleep 5

# Setup the dotfiles and configs
rm ~/.bashrc ~/.gitconfig ~/.vimrc ~/.zshrc ~/.Xresources ~/.ssh/config
rm -r ~/.config/compton ~/.config/polybar ~/.config/herbstluftwm ~/.config/mutt ~/.config/nitrogen ~/.config/ranger
cd ~/Dotfiles
./stowrestore
sudo cp -r ~/.config/polybar/fonts/* /usr/share/fonts
sudo fc-cache -vf /usr/share/fonts
doom sync
vim +PluginInstall +qall
cd ~
sleep 5

# Install complete
echo "Software installation complete. Please type in your password, then reboot the computer."

# Change shell
chsh -s $(which zsh)
