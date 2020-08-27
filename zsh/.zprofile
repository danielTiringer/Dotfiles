# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# Default programs
export EDITOR="vim"
export TERMINAL="urxvt"

# Keeping dotfiles in config
export BASHDOTDIR="$HOME/.config/bash"
export DOSBOXDIR="$HOME/.config/dosbox"
export GNUPGHOME="$HOME/.config/gnupg"
export NEWSBOATDIR="$HOME/.config/newsboat"
export XAUTHORITY="$HOME/.cache/xauthority"
export ZDOTDIR="$HOME/.config/zsh"

source $HOME/.config/zsh/aliasfunctions.sh

# Docker env
COMPOSE_DOCKER_CLI_BUILD=1
DOCKER_BUILDKIT=1
ARTIFACTORY_COMPOSER_AUTH='{"http-basic":{"artifactory.mpi-internal.com": {"username": "srv.scmh.zsozsobot@adevinta.com", "password": "AKCp5dKYyMd2aHSLpQhPXKHoxT2NwQkZZ7bPtrV6WhRNv3DDxVVxAyELyTKj5q6s9iEPqdVoE"}}}'

# PATH
export PATH=~/.local/bin:$PATH

export TERM=xterm-256color
