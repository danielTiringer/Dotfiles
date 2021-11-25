# Installs fonts from non-distro-specific sources

curl --fail --silent --show-error --location https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip -o ~/Downloads/UbuntuMono.zip
unzip ~/Downloads/UbuntuMono.zip -d ~/.local/share/fonts/
rm -rf ~/Downloads/UbuntuMono.zip
