#!/usr/bin/env bash

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via the extract function." ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

update () {
  distro_update

  editor_update

  shell_update

  docker_compose_update
}

distro_name () {
  awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }'
}

distro_update () {
  DISTRO=$(distro_name)
  if [ $DISTRO = 'debian' ] ; then
    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
  fi
  if [ $DISTRO = 'arch' ] ; then
    sudo pacman -Syuu
  fi
}

editor_update () {
  if [ -d "$HOME/.config/doom" ] ; then
    $HOME/.emacs.d/bin/doom sync
  fi
  if [ -d "$HOME/.vim" ]; then
    vim +PluginUpdate +qall
  fi
}

shell_update () {
  if [ -d "$HOME/.config/oh-my-zsh" ] ; then
    omz update
  fi
}

docker_compose_update () {
  if [ -x "$(command -v docker-compose)" ] ; then
    LATEST_COMPOSE_VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
    echo "The latest compose version is: $LATEST_COMPOSE_VERSION"
    OWN_COMPOSE_VERSION=$(docker-compose -v 2>/dev/null | awk '{print$4}')
    echo "The current compose version is: $OWN_COMPOSE_VERSION"
    if [ "$OWN_COMPOSE_VERSION" = "$LATEST_COMPOSE_VERSION" ]; then
        echo "Docker-compose is up to date."
    else
        SYSTEM_TYPE=$(uname -s)
        SYSTEM_ARCH=$(uname -m)
        COMPOSE_LOCATION=/usr/local/bin/docker-compose
        sudo rm $COMPOSE_LOCATION
        sudo curl -L --fail https://github.com/docker/compose/releases/download/${LATEST_COMPOSE_VERSION}/docker-compose-${SYSTEM_TYPE}-${SYSTEM_ARCH} -o $COMPOSE_LOCATION
        sudo chmod +x $COMPOSE_LOCATION
        sudo docker pull docker/compose:$LATEST_COMPOSE_VERSION
        echo "Docker-compose is upgraded, the new version is: $LATEST_COMPOSE_VERSION"
    fi
  fi
}
