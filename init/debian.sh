#!/bin/sh

# Start from a base Debian system without any graphical environments, but with git and sudo installed

# Install prompt
echo 'The executed script will install applications on a Debian based system.'
. "$INITDIR/common/check.sh"

# Create the basic file system
. "$INITDIR/common/folders.sh"

# Update the system
update_system

# Add the bullseye-backports repository
#echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" | sudo tee /etc/apt/sources.list.d/bullseye-backports.list

# Install ssh
install openssh-server sshpass

# Install network-based tools
install curl wget network-manager

# Install file system helpers
install nfs-common
install cifs-utils # For smb
install exfat-fuse exfat-utils # For FAT32 SD cards
install cryptsetup # For encrypted drives
install ntfs-3g # For NTFS based external drives

# Install basic tools for file management
install unzip unrar-free p7zip-full xclip libclipboard-perl

# Install command line tools
install neofetch stow arandr autorandr jq htop tig
. "$INITDIR/common/tig.sh"

# Install Debian-related tools
install apt-show-versions gdebi
install cron-apt
echo 'OPTIONS="-o quiet=2"
MAILON="NEVER"
DEBUG="verbose"' | sudo tee -a /etc/cron-apt/config

# Install build tools
install bc

# Install terminals
install rxvt-unicode
install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
. "$INITDIR/common/alacritty.sh"

# Install file manager
install vifm

# Install zsh, make it the default shell, and install oh-my-zsh
install zsh
. "$INITDIR/common/zsh.sh"

# Install the xorg graphical environment
install xorg

# Install fonts
install fonts-font-awesome
. "$INITDIR/common/fonts.sh"

# Install window manager basics
install nitrogen picom dmenu polybar xtrlock i3lock feh sxhkd lm-sensors rofi

# Install qtile
install python3-pip
install libxcb-render0-dev
install libpangocairo-1.0-0
. "$INITDIR/common/qtile.sh"

# Install herbstluftwm
install herbstluftwm

# Install bspwm
install bspwm

# Install i3
install i3-wm

# Install vim
install vim vim-gtk
. "$INITDIR/common/vim.sh"

# Install dependencies of neovim config
install python3-pip nodejs npm
curl_default https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && install yarn
. "$INITDIR/common/neovim-providers.sh"

# Install dependencies of neovim plugins
install silversearcher-ag fzf ripgrep fd-find

# Enable the jetbrains repository
curl_default https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com focal main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
sudo apt update -yy

# Configure file watchers
echo "fs.inotify.max_user_watches = 524288" | sudo tee /etc/sysctl.d/idea.conf
sudo sysctl -p --system

# Install phpstorm
install phpstorm

# Install intellij
install intellij-idea-community

# Install webstorm
install webstorm

# Install pycharm
install pycharm-community

# Install API tester
. "$INITDIR/common/postman.sh"

# Install database manager
curl_default https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/dbeaver.gpg
echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update -yy
install dbeaver-ce

# Install VPN client
install openvpn

# Set up firewall
install ufw
enable_service ufw
. "$INITDIR/common/ufw.sh"

# Install docker and docker-compose
install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl_default https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb http://download.docker.com/linux/debian $(lsb_release --codename --short) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update -yy
install docker-ce docker-ce-cli containerd.io

. "$INITDIR/common/docker-compose.sh"
sudo groupadd docker
sudo usermod -aG docker "$USER"
enable_service docker

# Install configuration management tools
install ansible
curl_default https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update -yy
install packer
install terraform

# Install browser
install firefox-esr

install apt-transport-https curl
sudo curl_default https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg --output /usr/share/keyrings/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -yy
install brave-browser

# Install multimedia
install  alsa-utils pulsemixer mpv

# Install password manager
. "$INITDIR/common/bitwarden.sh"

# Get wallpapers
. "$INITDIR/common/wallpaper.sh"

# Copy dotfiles
. "$INITDIR/common/dotfiles.sh"

# Run dotfile-related installs
. "$INITDIR/common/editor-installs.sh"

# Check if the hardware is a macbook, then install specific stuff
if [ "$(get_hardware_type)" = 'MacBook' ] ; then
	install mbpfan
	. "$INITDIR/specific/macbook-fan.sh"
	. "$INITDIR/specific/macbook-keyboard-brightness.sh"
fi

# Enable the unstable (sid) repository
#echo 'deb http://deb.debian.org/debian/ unstable main contrib non-free' | sudo tee /etc/apt/sources.list.d/unstable.list
#echo 'Package: *
#Pin: release a=stable
#Pin-Priority: 900

#Package: *
#Pin: release a=unstable
#Pin-Priority: 10' | sudo tee /etc/apt/preferences.d/99pin-unstable
#sudo apt update -yy

# Install programs from the unstable repo

# Install neovim
#install -t unstable neovim
#. "$INITDIR/common/neovim.sh"

# Install complete
. "$INITDIR/common/restart.sh"
