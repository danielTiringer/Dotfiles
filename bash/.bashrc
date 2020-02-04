# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias vtop="vtop --theme monokai"
alias config=/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME
alias config='/usr/bin/git --git-dir=/home/daniel/dotfiles --work-tree=/home/daniel'
alias dotfiles='git --git-dir=/home/daniel/.dotfiles/ --work-tree=/home/daniel'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
