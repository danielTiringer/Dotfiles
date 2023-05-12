# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# Aliases modifying existing commands
alias cp='cp -v'
alias df='df -h'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias mv='mv -v'
alias rm='rm -v'

if [ -e "$ZDOTDIR"/work_settings ] ; then
  . "$ZDOTDIR"/work_settings
fi
