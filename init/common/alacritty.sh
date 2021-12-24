#!/bin/sh
# Installs rust and builds alacritty from source

curl https://sh.rustup.rs -sSf | sh -s -- -y
. "$HOME"/.cargo/env
rustup override set stable
rustup update stable

ALACRITTY_VERSION=v$(curl --silent https://api.github.com/repos/alacritty/alacritty/releases/latest | jq .name --raw-output | cut -d ' ' -f3)

git clone https://github.com/alacritty/alacritty.git "$HOME"/Downloads/alacritty
cd "$HOME"/Downloads/alacritty
git checkout "$ALACRITTY_VERSION"

cargo build --release

sudo mv "$HOME"/Downloads/alacritty/target/release/alacritty /usr/local/bin/

cd
rm -rf "$HOME"/Downloads/alacritty
