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

source $ZDOTDIR/aliasfunctions.sh

# Generic aliases
alias afk='xtrlock -b'
alias df='df -h'
alias doom='~/.emacs.d/bin/doom'
alias hc='herbstclient'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias transmission='docker-compose -f ~/Downloads/transmission/transmission-compose.yml'
alias weather='curl wttr.in'

# Aliases modifying existing commands
alias cp='cp -v'
alias mv='mv -v --interactive'
alias rm='rm -v --interactive=once'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Software aliases
alias brave='brave-browser'

# GPG
# export GPG_TTY=$(tty)
# gpgconf --launch gpg-agent

# PATH
export PATH=~/.local/bin:$PATH

export TERM=xterm-256color
