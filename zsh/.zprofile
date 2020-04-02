# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin
#
# Generic aliases
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias afk='xtrlock'
alias hc='herbstclient'
alias ssh='ssh -A'
alias mountdrives='sudo mount /dev/sdb1 /media/2TBDrive && sudo mount /dev/sdc1 /media/4TBDrive'
alias doom="~/.emacs.d/bin/doom"
# alias emacs="urxvt -e emacs -nw"

# Software aliases
alias chrome='google-chrome'
alias brave='brave-browser'

# upload files from the Projects folder to docker-devel1, into the docker-hasznaltauto folder
alias upload="sh ~/.bin/syncDockerDevel1.sh"

# PATH
export PATH=~/.local/bin:$PATH

# Go PATH
# export PATH=$PATH:/usr/local/go/bin
# export GOPATH=$HOME/Documents/Go-sandbox

# added by travis gem
# [ -f /home/daniel/.travis/travis.sh ] && source /home/daniel/.travis/travis.sh

export TERM=xterm-256color

