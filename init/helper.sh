#!/bin/sh

# Functions used to aid the bootstrap script

check_distro() {
  cat /etc/os-release | grep "^ID=" | cut -d "=" -f2 | tr -d '"'
}

check_hardware_type() {
	if [ "$(sudo dmidecode --type 1 | grep 'Family:' | awk '{$1=$1;print}')" = 'Family: MacBook Pro' ] ; then
		echo 'MacBook'
	fi
}

change_shell_for_user() {
    echo "Changing the shell to zsh for ${USER}"

    LINE_NUMBER=$(grep -n "$USER" /etc/passwd | cut -d ":" -f 1)
    sudo sed -i -E "${LINE_NUMBER}s#/bin/b?ash#/bin/zsh#" /etc/passwd
}

enable_service() {
    echo "Enabling and starting the ${1} service."

    if [ -x "$(command -v systemctl)" ] ; then
        sudo systemctl enable "$1" --now
    elif [ -x "$(command -v rc-update)" ] ; then
        sudo rc-update add "$1" boot
        sudo service "$1" start
    elif [ -d "/etc/sv" ] ; then
        sudo ln -s /etc/sv/"$1" /var/service
    else
        echo "Unble to enable and start the ${1} service."
    fi
}

install() {
    echo "Installing the following packages: ${*}."

    if [ -x "$(command -v apk)" ] ; then
        sudo apk add "$@"
    elif [ -x "$(command -v pacman)" ] ; then
        sudo pacman -S --noconfirm "$@"
    elif [ -x "$(command -v apt)" ] ; then
        sudo apt install -yy "$@"
    elif [ -x "$(command -v xbps-install)" ] ; then
        sudo xbps-install -S --yes "$@"
    else
        echo "The following packages couldn't be installed: ${*}."
    fi
}

curl_default() {
    curl --fail --silent --show-error --location $@
}

update_system() {
    echo 'Updating the system...'

    if [ -x "$(command -v apk)" ] ; then
        sudo apk update
        sudo apk upgrade
    elif [ -x "$(command -v pacman)" ] ; then
        sudo pacman --sync --refresh --sysupgrade --noconfirm
    elif [ -x "$(command -v apt)" ] ; then
        sudo apt update -yy && sudo apt upgrade -yy --fix-missing
    elif [ -x "$(command -v xbps-install)" ] ; then
        sudo xbps-install --sync --yes --update
    else
        echo 'The system could not be upgraded.'
    fi
}

install_chrome_extension() {
  PREFERENCES_DIR_PATH="/opt/google/chrome/extensions"
  PREF_FILE_PATH="$PREFERENCES_DIR_PATH/$1.json"
  UPLOAD_URL="https://clients2.google.com/service/update2/crx"

  sudo mkdir -p "$PREFERENCES_DIR_PATH"
  printf '{\n "external_update_url": "%s"\n}\n' "$UPLOAD_URL" | sudo tee "$PREF_FILE_PATH"
  echo Added \""$PREF_FILE_PATH"\" ["$2"]
}

install_firefox_addon() {
  EXTENSION_DIR="$HOME/.mozilla/extensions"
  EXTENSION_FILENAME="${2}.xpi"
  UPSTREAM_URL="https://addons.mozilla.org/firefox/downloads/file"

  wget -O "${EXTENSION_DIR}/$EXTENSION_FILENAME" \
    "${UPSTREAM_URL}/${1}/addon-${1}-latest.xpi" ||
    exit $?
}
