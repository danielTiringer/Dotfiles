#!/bin/sh

. "$ZDOTDIR"/scripts/helpers.sh

update() {
  distro_update

  editor_update

  shell_update

  docker_compose_update

  bitwarden_cli_update

  balena_etcher_update
}

distro_update() {
  DISTRO=$(distro_name)

  case $DISTRO in
    alpine) sudo apk -U upgrade                             ;;
    arch)   sudo pacman -Syuu --noconfirm                   ;;
    debian) sudo nala update && sudo nala upgrade -y      ;;
	void)   sudo xbps-install --sync --yes --update         ;;
    *)      echo "This distro is not set up in the script." ;;
  esac
}

editor_update() {
  update_doom

  update_vim

  update_neovim
}

update_doom() {
  if [ -d "$HOME/.config/doom" ] && [ "$(alias doom)" = "doom='~/.config/emacs/bin/doom'" ] && [ -x "$(command -v emacs)" ] ; then
    "$HOME/.config/emacs/bin/doom" sync
  fi
}

update_vim() {
  if [ -d "$HOME/.vim" ] && [ -x "$(command -v vim)" ] ; then
    vim +PluginUpdate +qall
  fi
}

update_neovim() {
  if [ -d "$HOME/.config/nvim" ] && [ -x "$(command -v nvim)" ] ; then
    # Upgrades vim-plug itself
    nvim +PlugUpgrade +qall
    # Upgrades plugins installed via vim-plug
    nvim -es -u "$HOME/.config/nvim/init.vim" -i NONE -c "PlugInstall" -c "qa"

    if [ -x "$(command -v pip)" ] ; then
      pip install --upgrade pynvim
    fi
  fi
}

shell_update() {
  if [ -d "$HOME/.config/oh-my-zsh" ] ; then
    "$ZSH/tools/upgrade.sh"
  fi
}

docker_compose_update() {
  if [ -x "$(command -v docker-compose)" ] ; then
    LATEST_COMPOSE_VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name --raw-output)
    echo "The latest compose version is: $LATEST_COMPOSE_VERSION"

    OWN_COMPOSE_VERSION=$(docker-compose -v 2>/dev/null | awk '{print$4}')
    echo "The current compose version is: $OWN_COMPOSE_VERSION"

    if [ "$OWN_COMPOSE_VERSION" = "$LATEST_COMPOSE_VERSION" ]; then
        echo "Docker-compose is up to date."
    else
        SYSTEM_TYPE=$(uname --kernel-name)
        SYSTEM_ARCH=$(uname --machine)
        COMPOSE_LOCATION=/usr/local/bin/docker-compose

        sudo rm $COMPOSE_LOCATION
        sudo curl --fail --location "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-${SYSTEM_TYPE}-${SYSTEM_ARCH}" --output $COMPOSE_LOCATION
        sudo chmod +x $COMPOSE_LOCATION
        echo "Docker-compose is upgraded, the new version is: $LATEST_COMPOSE_VERSION."
    fi
  fi
}

bitwarden_cli_update() {
    BW_CLI_LOCATION="$HOME/.local/bin/bw"

    if [ -f "$BW_CLI_LOCATION" ] ; then
        LATEST_BITWARDEN_CLI_VERSION=$(curl --silent https://api.github.com/repos/bitwarden/cli/releases/latest | jq .name --raw-output | cut -d ' ' -f2)
        echo "The latest bitwarden-cli version is: $LATEST_BITWARDEN_CLI_VERSION"

        OWN_BITWARDEN_CLI_VERSION=$(bw --version)
        echo "The current bitwarden-cli version is: $OWN_BITWARDEN_CLI_VERSION"

        if [ "$OWN_BITWARDEN_CLI_VERSION" = "$LATEST_BITWARDEN_CLI_VERSION" ] ; then
            echo "Bitwarden cli is up to date."
        else
            BITWARDEN_URI="https://github.com/bitwarden/cli/releases/download/v$LATEST_BITWARDEN_CLI_VERSION/bw-linux-$LATEST_BITWARDEN_CLI_VERSION.zip"
            rm "$BW_CLI_LOCATION"

            curl --fail --location "$BITWARDEN_URI" --output "$HOME"/Downloads/bitwarden.zip
            unzip "$HOME"/Downloads/bitwarden.zip -d "$HOME"/.local/bin/
            rm "$HOME"/Downloads/bitwarden.zip
            sudo chmod +x "$BW_CLI_LOCATION"

            echo "Bitwarden cli is upgraded, the new version is: $LATEST_BITWARDEN_CLI_VERSION."
        fi
    fi
}

alacritty_update() {
    ALACRITTY_LOCATION="/usr/local/bin/alacritty"

    if [ -f "$ALACRITTY_LOCATION" ] ; then
        LATEST_ALACRITTY_VERSION=$(curl --silent https://api.github.com/repos/alacritty/alacritty/releases/latest | jq .name --raw-output | cut -d ' ' -f3)
        echo "The latest alacritty version is: $LATEST_ALACRITTY_VERSION"

        OWN_ALACRITTY_VERSION=$(alacritty --version | cut -d ' ' -f2)
        echo "The current alacritty version is: $OWN_ALACRITTY_VERSION"

        if [ "$OWN_ALACRITTY_VERSION" = "$LATEST_ALACRITTY_VERSION" ] ; then
            echo "Alacritty is up to date."
        else
            . "$HOME"/.cargo/env

            git clone https://github.com/alacritty/alacritty.git "$HOME"/Downloads/alacritty
            cd "$HOME"/Downloads/alacritty
            git checkout v"$LATEST_ALACRITTY_VERSION"

            cargo build --release

            sudo rm "$ALACRITTY_LOCATION"
            sudo mv "$HOME"/Downloads/alacritty/target/release/alacritty /usr/local/bin/

            cd
            rm -rf "$HOME"/Downloads/alacritty
        fi
    fi
}

balena_etcher_update() {
    if [ -x "$(command -v balena-etcher)" ] ; then
        LATEST_ETCHER_VERSION=$(curl --silent https://api.github.com/repos/balena-io/etcher/releases/latest | jq .name --raw-output | cut -d ' ' -f3 | sed 's/v//')
        echo "The latest balena etcher version is: $LATEST_ETCHER_VERSION"

        DISTRO=$(distro_name)
        if [ "$DISTRO" = "debian" ] ; then
            CURRENT_ETCHER_VERSION=$(dpkg --search balena-etcher | grep Version | cut -d ' ' -f 2)

            if [ "$LATEST_ETCHER_VERSION" = "$CURRENT_ETCHER_VERSION" ] ; then
                echo "Balena etcher is up to date."
            else
                sudo curl --fail --location "https://github.com/balena-io/etcher/releases/download/v${LATEST_ETCHER_VERSION}/balena-etcher_${LATEST_ETCHER_VERSION}_amd64.deb" --output "$HOME/Downloads/balena-etcher_${LATEST_ETCHER_VERSION}_amd64.deb"

                sudo dpkg --install "$HOME/Downloads/balena-etcher_${LATEST_ETCHER_VERSION}_amd64.deb"
                sudp apt update --yes
                sudo apt --fix-broken install --yes

                rm -f "$HOME/Downloads/balena-etcher_${LATEST_ETCHER_VERSION}_amd64.deb"
            fi
        else
            echo "There is no balena etcher update script for ${DISTRO}"
        fi
    fi
}