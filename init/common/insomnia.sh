#!/bin/sh

LATEST_INSOMNIA_VERSION=$(curl --silent https://api.github.com/repos/kong/insomnia/releases/latest | jq '.tag_name' | tr -d '"')
LATEST_INSOMNIA_FILENAME=$(curl --silent https://api.github.com/repos/kong/insomnia/releases/latest | jq '.assets[] | select(.name | strings | test(".tar.gz")) | .name' | tr -d '"')
INSOMNIA_URI="https://github.com/Kong/insomnia/releases/download/$LATEST_INSOMNIA_VERSION/$LATEST_INSOMNIA_FILENAME"
echo $INSOMNIA_URI

curl --fail --location "$INSOMNIA_URI" --output "$HOME"/Downloads/insomnia.tar.gz
tar --extract --verbose --gzip --file "$HOME"/Downloads/insomnia.tar.gz --directory="$HOME"/Downloads
rm "$HOME"/Downloads/insomnia.tar.gz
sudo mv "$HOME"/Downloads/Insomnia* /opt/Insomnia
sudo ln -s /opt/Insomnia/insomnia /usr/bin/insomnia
