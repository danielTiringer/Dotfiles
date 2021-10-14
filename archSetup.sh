#!/bin/bash

# Daniel's install script for Arch based distributions.

# Start from a base Arch install with your user already created, sudo and git installed

echo 'The executed script will install applications on an Arch based system.'

# Create the basic file system
cd ~
mkdir Downloads Pictures Documents Projects .config
sudo mkdir /media/{smb,MemCard,USB}
cd ~

# Update the system
sudo pacman --sync --refresh --sysupgrade

# Install ssh
sudo pacman -S --noconfirm openssh

# Install network-based tools
sudo pacman -S --noconfirm curl wget

# Install command-line tools
sudo pacman -S --noconfirm neofetch stow arandr xtrlock

# Install build tools
sudo pacman -S --noconfirm base-devel

# Install the yay aur-manager
cd ~/Downloads
git clone https://aur.archlinux.org/yay-git.git
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
sudo yay -S --noconfirm oh-my-zsh-git
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.config/oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sudo usermod --shell $(which zsh) $USER

# Install the xorg graphical environment
sudo pacman -S --noconfirm xf86-video-fbdev xorg xorg-xinit

# Install fonts
sudo pacman -S --noconfirm ttf-ubuntu-font-family ttf-dejavu ttf-font-awesome
sudo yay -S --noconfirm powerline-fonts-git

# Install vim plugin manager and plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install window manager basics
sudo pacman -S --noconfirm nitrogen picom

# Install window manager
sudo pacman -S --noconfirm qtile python-psutil

# Install emacs
sudo pacman -S --noconfirm emacs ripgrep fd
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# Install browser
sudo pacman -S --noconfirm firefox
wget -P ~/Downloads https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/user.js

# Install multimedia
sudo pacman -S --noconfirm mpv alsa-utils

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

# Install Postman
# cd ~/Downloads
# wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
# sudo tar -xvzf postman-linux-x64.tar.gz -C /opt
# sudo ln -s /opt/Postman/Postman /usr/bin/postman
# rm postman-linux-x64.tar.gz
# cd ~

# Copy dotfiles
cd ~/Dotfiles
./stowrestore
cd ~

# Run dotfile-related installs
doom sync
vim +PluginInstall +qall

# Install complete
echo "Software installation complete. Please type in your password, then reboot the computer."
