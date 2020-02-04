#!/bin/bash

# Daniel Tiringer's Install script for Debian based distributions, with a focus on software development.
#	     _      _     _
#	  __| | ___| |__ (_) __ _ _ __
#	 / _` |/ _ \ '_ \| |/ _` | '_ \
#	| (_| |  __/ |_) | | (_| | | | |
#	 \__,_|\___|_.__/|_|\__,_|_| |_|

# Install prompt
echo 'The executed script will install applications on a Debian based system.'
while true
do
	read -r -p 'Are you sure you want to proceed? [Y/n] ' input
	case $input in
		[Yy][Ee][Ss]|[Yy]) echo 'Starting script...'; sleep 3s; break;;
		[Nn][Oo]|[Nn]) echo 'User aborted.'; exit 1;;
		* ) echo 'Please answer yes or no.';;
	esac
done

# Create the basic file system

cd ~
mkdir Downloads Pictures Documents .config

# Update the system
cd ~
sudo apt update -qq

# Install basic tools for file management
sudo apt install -yy curl wget gdebi thefuck openssh-server gimp

# Install command line tools
sudo apt install -yy zsh ranger vifm neofetch rxvt-unicode mutt figlet

# Install window manager
sudo apt install -yy herbstluftwm nitrogen compton

# Install utilities
sudo apt install -yy network-manager alsa-utils xbacklight xorg xtrlock lm-sensors

# Install Vim

sudo apt install -yy vim vim-gtk
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Set up Vim templates

mkdir ~/.vim/templates
cd ~/.vim/templates
touch skeleton.html skeleton.sh skeleton.vue

sudo echo '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
</head>
<body>
</body>
</html>' >> ~/.vim/templates/skeleton.html

sudo echo '#!/bin/bash' >> ~/.vim/templates/skeleton.sh

sudo echo '<template>

</template>

<script>
export default {

}
</script>

<style scoped>

</style>' >> ~/.vim/templates/skeleton.vue

cd ~

# Set up Git

git config --global user.email "tiringerdaniel@gmail.com"
git config --global user.name "danielTiringer"
sudo apt install -yy tig

# Install Oh-My-Zsh

sudo apt install -yy fonts-powerline
sudo mkdir /usr/share/oh-my-zsh
cd /usr/share/oh-my-zsh
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
ZSH='/usr/share/oh-my-zsh' sh install.sh --unattended
cd ~

# Install Google Chrome

sudo cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo gdebi -n google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb
cd ~

# Install Firefox

# sudo apt install -yy firefox-esr

# Install Brave

sudo apt install -yy apt-transport-https curl
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ trusty main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-trusty.list
sudo apt update -qq
sudo apt install -yy brave-browser

# Install Visual Studio Code

# cd ~/Downloads
# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
# sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
# sudo apt install -yy apt-transport-https
# sudo apt update
# sudo apt install -yy code
# sudo cp ~/.dotfiles/"Menlo for Powerline.ttf" /usr/share/fonts
# sudo fc-cache -vf /usr/share/fonts
# sudo rm ~/Downloads/*.gpg
# cd ~

# Install Slack

# cd ~/Downloads
# wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
# sudo apt install ./slack-desktop-*.deb
# rm slack-desktop-*.deb
# cd ~

# Install Docker

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER

# Install Pulumi

cd Downloads
curl -fsSL https://get.pulumi.com | sh
cd ~

# Install Terraform

export TER_VER="0.12.18"
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
unzip terraform_${TER_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
which terraform
terraform -v
sleep 5

# Install ELK stack Docker image

cd ~/.config
git clone https://github.com/deviantony/docker-elk.git
cd ~

# Install Nagios Docker image
docker pull jasonrivers/nagios:latest
mkdir ~/.config/nagios
cd nagios
mkdir custom-plugins etc nagiosgraph var
mkdir nagiosgraph/etc nagiosgraph/var
cd ~

# Install NPM

cd ~
sudo apt install -yy npm
sudo npm i -g n
sudo n latest
# Uncomment if you want typescript
# sudo npm i -g typescript ts-node @types/node
# Uncomment if you want the tester package
# sudo npm i -g supertest tap-spec tape mocha chai
# Uncomment if you want node mysql
# sudo npm i -g mysql dotenv
# Uncomment if you want express
# sudo npm i -g express ejs
# Uncomment if you want nodemon
# sudo npm i -g nodemon

# Install Postman
cd ~/Downloads
wget https://dl.pstmn.io/download/latest/linux64 -O postman-linux-x64.tar.gz
sudo tar -xvzf postman-linux-x64.tar.gz -C /opt
sudo ln -s /opt/Postman/Postman /usr/bin/postman
rm postman-linux-x64.tar.gz
cd ~

# Fan control for MacBookPro

# sudo apt install -yy mbpfan

# Enabling bitmap fonts

cd ~/Downloads
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
sudo mv 70-yes-bitmaps.conf /etc/fonts/conf.d/
sudo mv /etc/fonts/conf.d/70-no-bitmaps.conf /etc/fonts/conf.avail
cd ~

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

# Setup the dotfiles and configs

cd Dotfiles
./stowrestore
sudo cp -r polybar/.config/polybar/fonts/* polybar/.config/polybar/fonts/termsyn /usr/share/fonts
sudo fc-cache -vf /usr/share/fonts
vim +PluginInstall +qall
cd ~

# Install MySQL
# cd ~/Downloads
# wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb
# sudo apt update
# sudo apt install -yy ./mysql-apt-config_0.8.13-1_all.deb
# sudo apt update
# sudo apt install -yy mysql-server
# rm *.deb
# cd ~

# Install Polybar

sudo apt install -yy cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev xcb libxcb-ewmh2
cd ~/Downloads
git clone https://github.com/jaagr/polybar.git
./polybar/build.sh
sudo rm -Rf polybar
cd ~

# Configure X server

sudo dpkg-reconfigure keyboard-configuration

# Install complete

echo "Software installation complete. Please type in your password, then reboot the computer."

# Change shell
sudo chsh -s /bin/zsh
