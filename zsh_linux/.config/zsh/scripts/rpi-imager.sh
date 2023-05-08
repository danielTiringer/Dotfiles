#!/usr/bin/env sh

. "$ZDOTDIR/scripts/helpers.sh"

raspberry_pi_imager() {
	if ! [ -x "$(command -v rpi-imager)" ] ; then
		DISTRO=$(distro_name)

		if [ $DISTRO = 'debian' ] ; then
			curl_default "https://downloads.raspberrypi.org/imager/imager_latest_amd64.deb" --output "$HOME/Downloads/imager.deb"
			sudo apt install -y "$HOME/Downloads/imager.deb"
			rm "$HOME/Downloads/imager.deb"
		elif [ $DISTRO = 'arch' ] ; then
			sudo pacman -S --noconfirm dosfstools
			yay -S --noconfirm rpi-imager
		fi
	fi

	echo 'See https://raspberrypi-guide.github.io/getting-started/install-operating-system for reference.'

	sudo rpi-imager
}
