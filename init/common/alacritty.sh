# Installs rust and builds alacritty from source

curl https://sh.rustup.rs -sSf | sh -s -- -y
. $HOME/.cargo/env
rustup override set stable
rustup update stable

git clone https://github.com/alacritty/alacritty.git ~/Downloads/alacritty
cd ~/Downloads/alacritty

cargo build --release

cd ~
rm -rf ~/Downloads/alacritty
