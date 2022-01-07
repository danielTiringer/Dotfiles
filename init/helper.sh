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

change_shell_for_user () {
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

update_system() {
    echo 'Updating the system...'

    if [ -x "$(command -v apk)" ] ; then
        sudo apk update
        sudo apk upgrade
    elif [ -x "$(command -v pacman)" ] ; then
        sudo pacman --sync --refresh --sysupgrade --noconfirm
    elif [ -x "$(command -v apt)" ] ; then
        sudo apt install -yy "$@"
    elif [ -x "$(command -v xbps-install)" ] ; then
        sudo xbps-install -S --yes "$@"
    else
        echo "The following packages couldn't be installed: ${*}."
    fi
}

install_chrome_extension () {
  preferences_dir_path="/opt/google/chrome/extensions"
  pref_file_path="$preferences_dir_path/$1.json"
  upd_url="https://clients2.google.com/service/update2/crx"
  sudo mkdir -p "$preferences_dir_path"
  printf '{\n "external_update_url": "%s"\n}\n' "$upd_url" | sudo tee "$pref_file_path"
  echo Added \""$pref_file_path"\" ["$2"]
}

install_firefox_addon () {
  extensiondir="${HOME}/.mozilla/extensions"
  extensionfilename="${2}.xpi"
  upstream="https://addons.mozilla.org/firefox/downloads/file"
  wget -O "${extensiondir}/$extensionfilename" \
    "${upstream}/${1}/addon-${1}-latest.xpi" ||
    exit $?
}
