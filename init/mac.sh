#!/bin/sh

# Start from a base MacOS (Catalina) system, with git installed (type `git` into the terminal and install the developer tools)

# Install prompt
echo 'The executed script will install applications on a MacOS based system.'

# Install homebrew
if test ! $(which brew); then
  sudo git # Need to get into sudo for brew, but not run it with sudo... weird stuff
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
fi

# Install intellij
if [ ! -x "/Applications/IntelliJ IDEA CE.app" ] ; then
  brew install --cask intellij-idea-ce
fi

# Install postman
if [ ! -x "/Applications/Postman.app" ] ; then
  brew install --cask postman
fi

# Install dbeaver
if [ ! -x "/Applications/DBeaver.app" ] ; then
  brew install --cask dbeaver-community
fi

# Install docker
[ if test ! $(which docker); then
  brew install --cask docker
fi

# Install chrome
if [ ! -x "/Applications/Google Chrome.app" ] ; then
  brew install --cask google-chrome
fi

# Install firefox
if [ ! -x "/Applications/Firefox.app" ] ; then
  curl \
    --location \
    "https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=en-US" \
     --output "$HOME"/Downloads/Firefox.dmg
  hdiutil attach Firefox.dmg -nobrowse -readonly
  cp -R /Volumes/Firefox/Firefox.app /Applications/
  hdiutil detach /Volumes/Firefox/ -force
  rm -r "$HOME"/Downloads/Firefox.dmg
fi
