#!/usr/bin/env bash

first_start() {
    download_firefox_privacy_file

    install_phpactor

    load_samba_credentials
}

download_firefox_privacy_file() {
    FOLDERS=(`find ~/.mozilla/firefox/* -maxdepth 1 -type d -name "*.default*"`)

    for FOLDER in "${FOLDERS[@]}" ; do
        curl --location https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/user.js --output "${FOLDER}/user.js"
    done
}

install_phpactor() {
    . "$ZDOTDIR"/scripts/composer.sh

    cd "$XDG_CONFIG_HOME"/composer
    composer install --ignore-platform-reqs
}

load_samba_credentials() {
    SAMBA_DIR="$XDG_CONFIG_HOME/samba/"

    if [ ! -d "$SAMBA_DIR" ] ; then
        mkdir -p "$SAMBA_DIR"
    fi

    USERNAME=$(bw get username samba)
    PASSWORD=$(bw get password samba)

    echo "username=$USERNAME\npassword=$PASSWORD" > "$XDG_CONFIG_HOME/samba/credentials"
}
