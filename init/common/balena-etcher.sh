#!/bin/sh
# Installs the latest balena etcher
LATEST_ETCHER_VERSION=$(curl --silent https://api.github.com/repos/balena-io/etcher/releases/latest | jq .name --raw-output | cut -d ' ' -f3 | sed 's/v//')

DISTRO=$(distro_name)
if [ "$DISTRO" = "debian" ] ; then
    CURRENT_ETCHER_VERSION=$(dpkg --search balena-etcher | grep Version | cut -d ' ' -f 2)

    sudo curl --fail --location "https://github.com/balena-io/etcher/releases/download/v${LATEST_ETCHER_VERSION}/balena-etcher_${LATEST_ETCHER_VERSION}_amd64.deb" --output "$HOME/Downloads/balena-etcher_${LATEST_ETCHER_VERSION}_amd64.deb"

    sudo dpkg --install "$HOME/Downloads/balena-etcher_${LATEST_ETCHER_VERSION}_amd64.deb"
    sudo apt update --yes
    sudo apt --fix-broken install --yes

    rm -f "$HOME/Downloads/balena-etcher_${LATEST_ETCHER_VERSION}_amd64.deb"
fi