#!/usr/bin/env bash

# Install script for Alpine based distributions.

# Get the base (extended) image from here after updating the version number:
# wget http://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86_64/alpine-extended-3.12.0-x86_64.iso

# Set up the wireless network using wpa_supplicant and wireless-tools:
# https://wiki.alpinelinux.org/wiki/Connecting_to_a_wireless_access_point

echo 'The executed script will install applications on an Alpine based system.'
source ./common/check.sh

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

user=$(tail -1 /etc/passwd | cut -f1 -d':')

# Create the basic file system
source ./common/folders.sh

# Enable extra repositories
sed -i '2,6s/#//g' /etc/apk/repositories

# Update the system
apk update
apk upgrade

# Install ZSH and Oh-My-Zsh
apk add zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Change default shell to latest added user
sed -i '$s/ash/zsh/' /etc/passwd

# Install Window Manager
setup-xorg-base
apk add herbstluftwm compton nitrogen rxvt-unicode

# Install utilities
apk add stow neofetch curl wget

# Get wallpapers
source ./common/wallpaper.sh

# Install Postman
# cd ~/Downloads
# wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
# sudo tar -xvzf postman-linux-x64.tar.gz -C /opt
# sudo ln -s /opt/Postman/Postman /usr/bin/postman
# rm postman-linux-x64.tar.gz
# cd ~
# sleep 5

# Setup the dotfiles and configs
cd ~/Dotfiles
./stowrestore
sudo cp -r ~/.config/polybar/fonts/* /usr/share/fonts
sudo fc-cache -vf /usr/share/fonts
doom sync
vim +PluginInstall +qall
cd ~

# Install complete
echo "Software installation complete. Please type in your password, then reboot the computer."

# Change shell
chsh -s $(which zsh)
