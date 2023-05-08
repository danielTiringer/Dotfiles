#!/usr/bin/env bash

first_start() {
    download_firefox_privacy_file

    install_phpactor

    load_samba_credentials
}

download_firefox_privacy_file() {
    FOLDERS=(`find ~/.mozilla/firefox/* -maxdepth 1 -type d -name "*.default*"`)

    for FOLDER in "${FOLDERS[@]}" ; do
        curl --location https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/user.js --output "$FOLDER/user.js"
    done
}

install_phpactor() {
    . "$ZDOTDIR"/scripts/composer.sh

    CURRENT_DIR=$PWD

    cd "$XDG_CONFIG_HOME"/composer
    composer install --ignore-platform-reqs
    sudo ln -s "$XDG_CONFIG_HOME/composer/vendor/bin/phpactor" /usr/local/bin/phpactor
    
    cd $CURRENT_DIR
}

load_samba_credentials() {
    SAMBA_DIR="$XDG_CONFIG_HOME/samba/"

    if [ ! -d "$SAMBA_DIR" ] ; then
        mkdir -p "$SAMBA_DIR"
    fi

    echo 'Enter the password for Bitwarden':
    SESSION_KEY="$(bw unlock)"
    SAMBA_USERNAME="$(bw get username samba --session $SESSION_KEY)"
    SAMBA_PASSWORD="$(bw get password samba --session $SESSION_KEY)"

    echo "username=$SAMBA_USERNAME\npassword=$SAMBA_PASSWORD" > "$XDG_CONFIG_HOME/samba/credentials"
}
