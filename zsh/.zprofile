# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
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
export NEWSBOATDIR="$HOME/.config/newsboat"
export XAUTHORITY="$HOME/.cache/xauthority"
export ZDOTDIR="$HOME/.config/zsh"

source $HOME/.config/zsh/aliasfunctions.sh

# Generic aliases
alias cp='cp -v'
alias mv='mv -v --interactive'
alias rm='rm -v --interactive=once'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias df='df -h'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias afk='xtrlock -b'
alias hc='herbstclient'
alias doom='~/.emacs.d/bin/doom'
alias transmission='docker-compose -f ~/Downloads/transmission/transmission-compose.yml'
alias weather='curl wttr.in'
# alias emacs="urxvt -e emacs -nw"

# Software aliases
alias chrome='google-chrome'
alias brave='brave-browser'

# GPG
# export GPG_TTY=$(tty)
# gpgconf --launch gpg-agent

# upload files from the Projects folder to docker-devel1, into the docker-hasznaltauto folder
alias upload="sh ~/.bin/syncDockerDevel1.sh"

# PATH
export PATH=~/.local/bin:$PATH

export TERM=xterm-256color
