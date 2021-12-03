# Installs the plugins / modules for the editors

# Installs phpactor as a php lsp
if [ -x "$(command -v composer)" ] && [ -f "$HOME/.config/composer/composer.json" ] ; then
    composer install --working-dir "$HOME/.config/composer"
    sudo ln -s "$HOME/.config/composer/vendor/bin/phpactor" /usr/local/bin/phpactor
fi
if [ -d "$HOME/.config/doom" ] && [ -f "$HOME/.config/emacs/bin/doom" ] ; then
    "$HOME/.config/emacs/bin/doom" sync
fi
if [ -x "$(command -v vim)" ] ; then
    vim +PluginInstall +qall
fi
if [ -x "$(command -v nvim)" ] ; then
    nvim +PlugInstall +qall
fi
