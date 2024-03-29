# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# Docker env
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

# Default programs
export EDITOR="vim"
export TERMINAL="alacritty"

# Define the XDG folder locations
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Keeping dotfiles in config
export BASHDOTDIR="$XDG_CONFIG_HOME/bash"
export DOSBOXDIR="$XDG_CONFIG_HOME/dosbox"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export LESSHISTFILE="-"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export XAUTHORITY="$XDG_CACHE_HOME/xauthority"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Coding
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# A bit of a hack to eliminate libxkbcommon errors, see
# https://bbs.archlinux.org/viewtopic.php?id=228658
export LC_ALL=en_US.UTF-8

# Set for alacritty, see:
# https://wiki.archlinux.org/title/Alacritty#Different_font_size_on_multiple_monitors
export WINIT_X11_SCALE_FACTOR=1.25

# PATH
export PATH=~/.local/bin:$PATH

export TERM=xterm-256color
