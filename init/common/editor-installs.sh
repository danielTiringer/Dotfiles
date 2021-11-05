# Installs the plugins / modules for the editors

if [ -d "$HOME/.config/doom" ] && [ -f "$HOME/.config/emacs/bin/doom" ] ; then
    "$HOME/.config/emacs/bin/doom" sync
fi
if [ -x "$(command -v vim)" ] ; then
    vim +PluginInstall +qall
fi
if [ -x "$(command -v nvim)" ] ; then
    nvim +PlugInstall +qall
fi
