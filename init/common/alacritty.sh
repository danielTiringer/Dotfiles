# Installs rust and builds alacritty from source

curl https://sh.rustup.rs -sSf | sh -s -- -y
. $HOME/.cargo/env
rustup override set stable
rustup update stable

ALACRITTY_VERSION=0.9.0

git clone https://github.com/alacritty/alacritty.git $HOME/Downloads/alacritty
cd $HOME/Downloads/alacritty
git checkout "$ALACRITTY_VERSION"

cargo build --release

sudo mv $HOME/Downloads/alacritty/target/release/alacritty /usr/local/bin/

cd
rm -rf $HOME/Downloads/alacritty
