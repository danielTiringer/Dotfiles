# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# Docker env
COMPOSE_DOCKER_CLI_BUILD=1
DOCKER_BUILDKIT=1
ARTIFACTORY_COMPOSER_AUTH='{"http-basic":{"artifactory.mpi-internal.com": {"username": "srv.scmh.zsozsobot@adevinta.com", "password": "AKCp5dKYyMd2aHSLpQhPXKHoxT2NwQkZZ7bPtrV6WhRNv3DDxVVxAyELyTKj5q6s9iEPqdVoE"}}}'

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

# Generic aliases
alias cp='cp -iv'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias afk='xtrlock'
alias hc='herbstclient'
alias mountdrives='sudo mount /dev/sdb1 /media/2TBDrive && sudo mount /dev/sdc1 /media/4TBDrive'
alias doom='~/.emacs.d/bin/doom'
alias transmission='docker-compose -f ~/Downloads/transmission/transmission-compose.yml'
alias qbittorrent='docker-compose -f ~/.bin/qbittorrent-compose.yml'
# alias emacs="urxvt -e emacs -nw"

# Software aliases
alias chrome='google-chrome'
alias brave='brave-browser'

# upload files from the Projects folder to docker-devel1, into the docker-hasznaltauto folder
alias upload="sh ~/.bin/syncDockerDevel1.sh"

# PATH
export PATH=~/.local/bin:$PATH

export TERM=xterm-256color
