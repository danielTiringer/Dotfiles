source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-config/fzf.vim
luafile $HOME/.config/nvim/plug-config/compe-config.lua
luafile $HOME/.config/nvim/plug-config/treesitter.lua
source $HOME/.config/nvim/general/settings.vim
" Not all options can be expressed in lua - keeping this here
" source $HOME/.config/nvim/plug-config/nvim-tree.vim
luafile $HOME/.config/nvim/plug-config/nvim-tree.lua
source $HOME/.config/nvim/keys/mappings.vim

" LSP
source $HOME/.config/nvim/plug-config/lsp-config.vim
luafile $HOME/.config/nvim/keys/lsp.lua
luafile $HOME/.config/nvim/plug-config/php.lua
" luafile $HOME/.config/nvim/plug-config/java.lua

" Themes
source $HOME/.config/nvim/themes/onedark.vim
source $HOME/.config/nvim/themes/airline.vim
