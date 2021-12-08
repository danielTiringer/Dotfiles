#!/bin/sh

# Functions used to aid the bootstrap script

check_distro() {
  awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }'
}

change_shell_for_user () {
    LINE_NUMBER=$(grep -n $USER /etc/passwd | cut -d ":" -f 1)
    sudo sed -i -E "${LINE_NUMBER}s#/bin/b?ash#/bin/zsh#" /etc/passwd
}

install_chrome_extension () {
  preferences_dir_path="/opt/google/chrome/extensions"
  pref_file_path="$preferences_dir_path/$1.json"
  upd_url="https://clients2.google.com/service/update2/crx"
  sudo mkdir -p "$preferences_dir_path"
  sudo printf '{\n "external_update_url": "%s"\n}\n' "$upd_url" > "$pref_file_path"
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
