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
export TERMINAL="urxvt"

# Keeping dotfiles in config
export BASHDOTDIR="$HOME/.config/bash"
export DOSBOXDIR="$HOME/.config/dosbox"
export GNUPGHOME="$HOME/.config/gnupg"
export XAUTHORITY="$HOME/.cache/xauthority"
export ZDOTDIR="$HOME/.config/zsh"

# PATH
export PATH=~/.local/bin:$PATH

export TERM=xterm-256color