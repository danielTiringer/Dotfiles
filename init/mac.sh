#!/bin/sh

# Start from a base MacOS (Catalina) system, with git installed (type `git` into the terminal and install the developer tools)

# Install prompt
echo 'The executed script will install applications on a MacOS based system.'

# Load helper functions
. "$INITDIR/mac_helpers.sh"

# Install homebrew
if test ! $(which brew); then
  sudo git # Need to get into sudo for brew, but not run it with sudo... weird stuff
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update
else
  echo "Homebrew is already installed"
fi

# Install iterm2
install_brew_cask iterm2

# Install nerd fonts
apply_brew_tap homebrew/cask-fonts

install_brew_cask font-dejavu-sans-mono-nerd-font
install_brew_cask font-jetbrains-mono-nerd-font
install_brew_cask font-ubuntu-nerd-font

# Install oh-my-zsh
if [ ! -x "$HOME/.oh-my-zsh" ] ; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME"/.oh-my-zsh
  git clone https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

# Install intellij
install_brew_cask intellij-idea-ce

# Install postman
install_brew_cask postman

# Install dbeaver
install_brew_cask dbeaver

# Install docker
install_brew_cask docker

# Install chrome
install_brew_cask google-chrome

# Install firefox
install_brew_cask firefox

# Install gnu stow
install_brew_formula stow

# Stow dotfiles
. "$STOW_DIR/stow_mac.sh"

# Install vim dependencies
. "$INITDIR/common/vim.sh"
. "$INITDIR/common/editor-installs.sh"
