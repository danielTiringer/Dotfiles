#!/bin/sh

apply_brew_tap() {
  if brew tap | grep "$1" > /dev/null ; then
    echo "Tap $1 is aready applied"
  else
    brew tap "$1"
  fi
}

install_brew_formula() {
  if brew list --formula | grep "$1" > /dev/null ; then
    echo "Formula $1 is already installed"
  else
    brew install $1
  fi
}

install_brew_cask() {
  if brew list --casks | grep "$1" > /dev/null ; then
    echo "Cask $1 is already installed"
  else
    brew install --cask "$1"
  fi
}
