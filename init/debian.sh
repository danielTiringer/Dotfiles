#!/bin/sh

# Start from a base Debian system without any graphical environments, but with git and sudo installed

# Install prompt
echo 'The executed script will install applications on a Debian based system.'
. "$INITDIR/common/check.sh"

# Create the basic file system
. "$INITDIR/common/folders.sh"

# Update the system
update_system

# Install ssh
install openssh-server

# Install network-based tools
install curl wget network-manager

# Install file system helpers
install nfs-common
install cifs-utils # For smb
install exfat-fuse # For FAT32 SD cards
install cryptsetup # For encrypted drives
install ntfs-3g # For NTFS based external drives

# Install basic tools for file management
install unzip unrar-free p7zip-full xclip libclipboard-perl

# Install command line tools
install stow jq htop tig
. "$INITDIR/common/tig.sh"

# Install Debian-related tools
install nala

# Install build tools
install bc

# Install terminals
install rxvt-unicode
install alacritty

# Install file manager
install vifm

# Install fonts
install fonts-font-awesome
. "$INITDIR/common/fonts.sh"

# Install zsh, make it the default shell, and install oh-my-zsh
install zsh
. "$INITDIR/common/zsh.sh"

if ! is_wayland ; then

    # Install graphical tools
    install arandr autorand

    # Install the xorg graphical environment
    install xorg

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

    # Install multimedia
    install alsa-utils pulsemixer

fi

# Install vim
install vim
. "$INITDIR/common/vim.sh"

# Enable the jetbrains repository
curl_default https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | gpg --dearmor | sudo tee /usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jetbrains-ppa-archive-keyring.gpg] http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com any main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
sudo apt update -yy

# Configure file watchers
echo "fs.inotify.max_user_watches = 524288" | sudo tee /etc/sysctl.d/idea.conf
sudo sysctl -p --system

# Install phpstorm
install phpstorm

# Install intellij
install intellij-idea-ultimate

# Install webstorm
install webstorm

# Install pycharm
install pycharm-professional

# Install API tester
. "$INITDIR/common/postman.sh"

# Install database manager
curl_default https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/dbeaver.gpg
echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg.key] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
sudo apt update -yy
install dbeaver-ce

# Set up firewall
install ufw
enable_service ufw
. "$INITDIR/common/ufw.sh"

# Install docker and docker-compose
install apt-transport-https ca-certificates curl gnupg2 software-properties-common
sudo install -m 0755 -d /etc/apt/keyrings
curl_default https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -yy
install docker-ce docker-ce-cli containerd.io docker-compose

sudo groupadd docker
sudo usermod -aG docker "$USER"
enable_service docker

# Install configuration management tools
UBUNTU_CODENAME=jammy
curl_default "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | gpg --dearmour | sudo tee /usr/share/keyrings/ansible-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
sudo apt update -y
install ansible

install gnupg software-properties-common
curl_default https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
#wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -yy
install packer
install terraform

# Install browser
install firefox-esr

install apt-transport-https curl
curl_default https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/brave-browser-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -yy
install brave-browser

# Install multimedia
install mpv vlc

# Download appimage tools
curl_default https://raw.githubusercontent.com/un1t/appimage-desktop-entry/refs/heads/master/appimage-desktop-entry.sh -o $HOME/.local/bin/appimage-desktop-entry.sh
sudo chmod +x $HOME/.local/bin/appimage-desktop-entry.sh

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

# Install complete
. "$INITDIR/common/restart.sh"
