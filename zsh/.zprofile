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
alias mountdrives='sudo mount /dev/sdb1 /media/2TBDrive && sudo mount /dev/sdc1 /media/4TBDrive'

# Software aliases
alias chrome='google-chrome'
alias brave='brave-browser'

# Monitoring tools
alias elk-up='docker-compose -f ~/.config/docker-elk/docker-compose.yml up -d'
alias elk-down='docker-compose -f ~/.config/docker-elk/docker-compose.yml down'
alias nagios-create='docker run -d --name nagios4 \
  -v ~/.config/nagios/etc/:/opt/nagios/etc/ \
  -v ~/.config/nagios/var:/opt/nagios/var/ \
  -v ~/.config/nagios/custom-plugins:/opt/Custom-Nagios-Plugins \
  -v ~/.config/nagios/nagiosgraph/var:/opt/nagiosgraph/var \
  -v ~/.config/nagios/nagiosgraph/etc:/opt/nagiosgraph/etc \
  -p 0.0.0.0:8000:80 jasonrivers/nagios:latest'
alias nagios-up='docker start nagios4'
alias nagios-down='docker stop nagios4'

# PATH
export PATH=~/.local/bin:$PATH

# Pulumi PATH
export PATH=$PATH:$HOME/.pulumi/bin

# Go PATH
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Documents/Go-sandbox

# added by travis gem
[ -f /home/daniel/.travis/travis.sh ] && source /home/daniel/.travis/travis.sh
