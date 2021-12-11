#!/usr/bin/env bash

first_start() {
    firefox_privacy_download
}

firefox_privacy_download() {
    FOLDERS=(`find ~/.mozilla/firefox/* -maxdepth 1 -type d -name "*.default*"`)

    for FOLDER in "${FOLDERS[@]}" ; do
        curl --location https://raw.githubusercontent.com/ghacksuserjs/ghacks-user.js/master/user.js --output "${FOLDER}/user.js"
    done
}
