#!/bin/sh

extract ()
{
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
  DISTRO=$(lsb_release -ar 2>/dev/null | grep ID | cut -s -f2)
  if [ $DISTRO = 'Debian' ] ; then
    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
  fi
  if [ -d "$HOME/.config/doom" ]; then
    $HOME/.emacs.d/bin/doom sync
  fi
  if [ -d "$HOME/.vim" ]; then
    vim +PluginUpdate +qall
  fi
  if [ -d "$HOME/.config/oh-my-zsh" ]; then
    omz update
  fi

  LATEST_COMPOSE_VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
  OWN_COMPOSE_VERSION=$(docker-compose -v 2>/dev/null | awk '{print$3}' | tr -d ",")
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
}
