#!/bin/sh
# Installs the latest packer binary

install_hashicorp_product() {
  BINARY_LOCATION="$HOME/.local/bin/$1"

  LATEST_BINARY_VERSION=$(curl --silent https://api.github.com/repos/hashicorp/"$1"/releases/latest | jq .name --raw-output | sed 's/v//g')

  PACKER_URI=https://releases.hashicorp.com/"$1"/"$LATEST_BINARY_VERSION"/"$1"_"$LATEST_BINARY_VERSION"_linux_amd64.zip

  curl --fail --silent "$PACKER_URI" --output "$HOME/Downloads/"$1".zip"
  unzip "$HOME"/Downloads/"$1".zip -d "$HOME"/.local/bin/
  rm "$HOME"/Downloads/"$1".zip
  sudo chmod +x "$BINARY_LOCATION"
}
