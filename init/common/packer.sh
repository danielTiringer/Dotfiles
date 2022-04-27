#!/bin/sh
# Installs the latest packer binary

PACKER_LOCATION="$HOME/.local/bin/packer"

LATEST_PACKER_VERSION=$(curl --silent https://api.github.com/repos/hashicorp/packer/releases/latest | jq .name --raw-output | sed 's/v//g')

PACKER_URI=https://releases.hashicorp.com/packer/"$LATEST_PACKER_VERSION"/packer_"$LATEST_PACKER_VERSION"_linux_amd64.zip

curl --fail --silent "$PACKER_URI" --output "$HOME/Downloads/packer.zip"
unzip "$HOME"/Downloads/packer.zip -d "$HOME"/.local/bin/
rm "$HOME"/Downloads/packer.zip
sudo chmod +x "$PACKER_LOCATION"