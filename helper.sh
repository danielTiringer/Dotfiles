#!/bin/bash
check_distro() {
	lsb_release -ar 2>/dev/null | grep ID | cut -s -f2
}

install_chrome_extension () {
  preferences_dir_path="/opt/google/chrome/extensions"
  pref_file_path="$preferences_dir_path/$1.json"
  upd_url="https://clients2.google.com/service/update2/crx"
  sudo mkdir -p "$preferences_dir_path"
	sudo printf '{\n "external_update_url": "%s"\n}\n' "$upd_url" > "$pref_file_path"
  echo Added \""$pref_file_path"\" ["$2"]
}
