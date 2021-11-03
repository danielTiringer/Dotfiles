# Install the components of doom emacs

mkdir -p ~/.config/emacs/.local/straight/repos
git clone https://github.com/hlissner/doom-emacs ~/.config/emacs
PATH="$HOME/.config/emacs/bin:$PATH"
git clone -b develop https://github.com/raxod502/straight.el ~/./config/emacs/.local/straight/repos/straight.el
doom env
