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
COMPOSE_DOCKER_CLI_BUILD=1
DOCKER_BUILDKIT=1

# # Generic aliases
# alias poweroff='systemctl poweroff'
# alias reboot='systemctl reboot'
# alias afk='xtrlock'
# alias mountdrives='sudo mount /dev/sdb1 /media/2TBDrive && sudo mount /dev/sdc1 /media/4TBDrive'

# # Software aliases
# alias chrome='google-chrome'
# alias brave='brave-browser'

# # Monitoring tools
# alias elk-up='docker-compose -f ~/.config/docker-elk/docker-compose.yml up -d'
# alias elk-down='docker-compose -f ~/.config/docker-elk/docker-compose.yml down'
# alias nagios-create='docker run -d --name nagios4 \
#   -v ~/.config/nagios/etc/:/opt/nagios/etc/ \
#   -v ~/.config/nagios/var:/opt/nagios/var/ \
#   -v ~/.config/nagios/custom-plugins:/opt/Custom-Nagios-Plugins \
#   -v ~/.config/nagios/nagiosgraph/var:/opt/nagiosgraph/var \
#   -v ~/.config/nagios/nagiosgraph/etc:/opt/nagiosgraph/etc \
#   -p 0.0.0.0:8000:80 jasonrivers/nagios:latest'
# alias nagios-up='docker start nagios4'
# alias nagios-down='docker stop nagios4'

# # PATH
# export PATH=~/.local/bin:$PATH

# # Pulumi PATH
# export PATH=$PATH:$HOME/.pulumi/bin

# # Go PATH
# export PATH=$PATH:/usr/local/go/bin
# export GOPATH=$HOME/Documents/Go-sandbox

# # added by travis gem
# [ -f /home/daniel/.travis/travis.sh ] && source /home/daniel/.travis/travis.sh

