##!/bin/sh

. "${ZDOTDIR}/helpers.sh"

update () {
  distro_update

  editor_update

  shell_update

  docker_compose_update

  bitwarden_cli_update
}

distro_update () {
  DISTRO=$(distro_name)

  case $DISTRO in
    alpine) sudo apk -U upgrade                                               ;;
    arch)   sudo pacman -Syuu --noconfirm                                     ;;
    debian) sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y  ;;
    fedora) sudo dnf upgrade -y --refresh                                     ;;
	void)   sudo xbps-install --sync --yes --update                           ;;
    *)      echo -n "This distro is not set up in the script."                ;;
  esac
}

editor_update () {
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

shell_update () {
  if [ -d "$HOME/.config/oh-my-zsh" ] ; then
    omz update
  fi
}

docker_compose_update () {
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

bitwarden_cli_update () {
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
            rm $BW_CLI_LOCATION

            curl --fail --location "$BITWARDEN_URI" --output $HOME/Downloads/bitwarden.zip
            unzip $HOME/Downloads/bitwarden.zip -d $HOME/.local/bin/
            sudo chmod +x $BW_CLI_LOCATION

            echo "Bitwarden cli is upgraded, the new version is: $LATEST_BITWARDEN_CLI_VERSION."
        fi
    fi
}
