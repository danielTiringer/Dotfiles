# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

. "$ZDOTDIR"/aliasfunctions.sh

# Generic aliases
alias afk='i3lock --color 000000 --pointer default --nofork --ignore-empty-password --show-failed-attempts'
alias doom="$XDG_CONFIG_HOME/emacs/bin/doom"
alias hc='herbstclient'
alias weather='curl wttr.in'

# Aliases modifying existing commands
alias cp='cp -v'
alias df='df -h'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias mv='mv -v --interactive'
alias rm='rm -v --interactive=once'
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

# Aliases to keep the $HOME directory cleaner:
alias dosbox="dosbox -conf $XDG_CONFIG_HOME/dosbox/dosbox-0.74-3.conf"

# Aliases used for coding
alias sail='[ -f sail ] && zsh sail || zsh vendor/bin/sail'

# GPG
# export GPG_TTY=$(tty)
# gpgconf --launch gpg-agent
