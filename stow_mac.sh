#!/bin/sh

echo "Restoring dotfiles"
sleep 1

remove_local_files() {
  local files=(
    ".zshrc"
    ".vimrc"
  )
  local folders=(
    ".vim"
  )
  echo "Removing existing config files"
  for f in $files; do
    rm -f "$HOME/$f" || true
  done
  for d in $folders; do
    rm -rf "$HOME/$d" || true
  done
}
remove_local_files

stow -v -R gitdir
stow -v -R vim
stow -v -R zsh_mac

echo "Restoration complete"
