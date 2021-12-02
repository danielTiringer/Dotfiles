# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

source $ZDOTDIR/aliasfunctions.sh

# Generic aliases
alias afk='xtrlock -b'
alias doom='~/.config/emacs/bin/doom'
alias hc='herbstclient'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias weather='curl wttr.in'

# Aliases modifying existing commands
alias cp='cp -v'
alias df='df -h'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias mv='mv -v --interactive'
alias rm='rm -v --interactive=once'

# Aliases to keep the $HOME directory cleaner:
alias dosbox='dosbox -conf "$XDG_CONFIG_HOME"/dosbox/dosbox-0.74-3.conf'

# Software aliases
alias brave='brave-browser'

# GPG
# export GPG_TTY=$(tty)
# gpgconf --launch gpg-agent
