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
sudo mkdir -p /media/{2TBDrive,4TBDrive,4TBEnglishMedia,MemCard,USB}
cd ~

# Update the system
sudo apt update -yy
sudo apt upgrade -yy --fix-missing
sleep 5

# Install basic tools for file management
sudo apt install -yy curl wget gdebi thefuck openssh-server jq unzip ntfs-3g stow xclip libclipboard-perl
sleep 5

# Install command line tools
sudo apt install -yy zsh ranger neofetch rxvt-unicode neomutt figlet bc newsboat apt-show-versions
sleep 5

# Set up bluetoothctl
sudo apt install -yy pulseaudio-module-bluetooth bluetooth bluez bluez-tools rfkill
sudo usermod -aG lp $USER
pulseaudio -k
pulseaudio --start

# Install window manager basics
sudo apt install -yy nitrogen compton fonts-font-awesome
sleep 5

# Install herbstluftwm
sudo apt install -yy herbstluftwm
sleep 5

# Install qtile
sudo apt install -yy python3-pip
pip3 install xcffib psutil
pip3 install --no-cache-dir cairocffi
sudo apt install -yy libpangocairo-1.0-0
pip3 install qtile

sudo echo '[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec=qtile start
Type=Application
Keywords=wm;tiling' >> ~/Downloads/qtile.desktop
sudo mv ~/Downloads/qtile.desktop /usr/share/xsessions
sleep 5

# Install utilities
sudo apt install -yy network-manager alsa-utils xbacklight xorg xtrlock lm-sensors pulsemixer
sleep 5

# Install cron-apt
sudo apt install -yy cron-apt
sudo echo 'OPTIONS="-o quiet"
MAILON="NEVER"
DEBUG="verbose"' >> /etc/cron-apt/config
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

# Set up Git
git config --global user.email "tiringerdaniel@gmail.com"
git config --global user.name "danielTiringer"
sudo apt install -yy tig
sleep 5

# Generate SSH key for Github
mkdir ~/.ssh
ssh-keygen -t rsa -b 4096 -C "tiringerdaniel@gmail.com" -f ~/.ssh/id_rsa_$(hostname) -q -N ""
sleep 5

# Set up firewall
sudo apt install -yy ufw
sudo systemctl enable ufw.service --now
sudo ufw enable
sudo ufw allow Transmission
sudo ufw limit SSH
sudo ufw limit OpenSSH

# Install Vim
sudo apt install -yy vim vim-gtk vifm
sleep 5

# Install emacs
sudo apt install -yy emacs
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
PATH="$HOME/.emacs.d/bin:$PATH"
mkdir -p ~/.emacs.d/.local/straight/repos
git clone -b develop https://github.com/raxod502/straight.el ~/.emacs.d/.local/straight/repos/straight.el
doom env
emacs --batch -f all-the-icons-install-fonts

# Enabling bitmap fonts
sudo echo '<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <its:rules xmlns:its="http://www.w3.org/2005/11/its" version="1.0">
    <its:translateRule translate="yes" selector="/fontconfig/*[yes(self::description)]"/>
  </its:rules>

  <description>Accept bitmap fonts</description>
<!-- Accept bitmap fonts -->
 <selectfont>
  <acceptfont>
   <pattern>
     <patelt name="scalable"><bool>true</bool></patelt>
   </pattern>
  </acceptfont>
 </selectfont>
</fontconfig>' >> 70-yes-bitmaps.conf
sudo mv 70-yes-bitmaps.conf /etc/fonts/conf.avail
sudo ln -sf /etc/fonts/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d
sudo mv /etc/fonts/conf.d/70-no-bitmaps.conf /etc/fonts/conf.avail
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

# Install Google Chrome and extensions
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb

# install_chrome_extension "fmkadmapgofadopljbjfkapdkoienihi" "react dev tools"
# install_chrome_extension "lmhkpmbekcpmknklioeibfkpmmfibljd" "redux dev tools"
# install_chrome_extension "nhdogjmejiglipccpnnnanhbledajbpd" "vue dev tools"

cd ~
sleep 5

# Install Firefox
sudo apt install -yy firefox-esr
firefox_default="`find ~/.mozilla/firefox -type d -iname '*.default'`"
firefox_esr_default="`find ~/.mozilla/firefox -type d -iname '*.default-esr'`"
wget -P $firefox_default https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/user.js
cp $firefox_default/user.js $firefox_esr_default/
# install_firefox_addon '3592823' 'browser-extension@anonaddy' # Anonaddy email creator
# install_firefox_addon '3600118' 'uBlock0@raymondhill.ne' # uBlock Origin
# install_firefox_addon '3454607' '{5caff8cc-3d2e-4110-a88a-003cc85b3858}' # VueJS Devtools
# install_firefox_addon '3606608' '@react-devtools' # React Devtools
# install_firefox_addon '3518684' '{d7742d87-e61d-4b78-b8a1-b469842139fa}' # Vimium
# install_firefox_addon '3606067' '@testpilot-containers' # Multi Account Containers
# install_firefox_addon '3604699' 'jid1-ZAdIEUB7XOzOJw@jetpack' # DuckDuckGo
sleep 5

# Install Brave
sudo apt install -yy apt-transport-https
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ trusty main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-trusty.list
sudo apt update -qq
sudo apt install -yy brave-browser
sleep 5

# Install Docker and Docker-Compose
COMPOSE_VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
COMPOSE_LOCATION=/usr/local/bin/docker-compose
sudo sh -c "$(curl -fsSL https://get.docker.com)"
sudo curl -L --fail https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/run.sh -o $COMPOSE_LOCATION
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

# Install Travis CLI
# sudo gem install travis -v 1.8.10 --no-rdoc --no-ri
# sleep 5

# Install Polybar
sudo apt install -yy cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2 libjsoncpp-dev
cd ~/Downloads
git clone https://github.com/jaagr/polybar.git
cd polybar
./build.sh
cd ..
sudo rm -Rf polybar
cd ~

# Install Virt-Manager
sudo apt-get install -y qemu qemu-kvm qemu-system qemu-utils
sudo apt-get install -y virtinst libvirt-clients libvirt-daemon-system
sudo systemctl start libvirtd
sudo virsh net-start default
sudo virsh net-autostart default
sudo apt-get install -y virt-manager
sudo usermod -G libvirt -a $USER
sudo /etc/init.d/networking restart

# Install Dosbox
sudo apt install -y dosbox

# Setup the dotfiles and configs
rm ~/.bashrc ~/.gitconfig ~/.vimrc ~/.zshrc ~/.Xresources ~/.ssh/config
rm -r ~/.config/compton ~/.config/polybar ~/.config/herbstluftwm ~/.config/mutt ~/.config/nitrogen ~/.config/ranger
cd ~/Dotfiles
./stowrestore
sudo cp -r ~/.config/polybar/fonts/* /usr/share/fonts
sudo fc-cache -vf /usr/share/fonts
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
doom sync
vim +PluginInstall +qall
cd ~
sleep 5

# Configure X server
sudo dpkg-reconfigure keyboard-configuration

# Update the system from Buster to Bullseye
# sudo sed -i 's/debian-security buster/debian-security bullseye-security/g' /etc/apt/sources.list
# sudo sed -i 's/buster/bullseye/g' /etc/apt/sources.list
# sudo echo 'deb http://deb.debian.org/debian buster-backports main' | sudo tee -a /etc/apt/sources.list
# echo 'Updated the system from buster to bullseye.'
# sleep 5

# Install complete
echo "Software installation complete. Please reboot the computer."
