source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/vim-plug/plugins.lua
source $HOME/.config/nvim/plug-config/fzf.vim
luafile $HOME/.config/nvim/plug-config/compe-config.lua
luafile $HOME/.config/nvim/plug-config/treesitter.lua
luafile $HOME/.config/nvim/general/providers.lua
luafile $HOME/.config/nvim/general/settings.lua
source $HOME/.config/nvim/general/settings.vim
" Not all options can be expressed in lua - keeping this here
" source $HOME/.config/nvim/plug-config/nvim-tree.vim
luafile $HOME/.config/nvim/plug-config/nvim-tree.lua
luafile $HOME/.config/nvim/keys/mappings.lua

" LSP
luafile $HOME/.config/nvim/plug-config/lsp-config.lua
luafile $HOME/.config/nvim/keys/lsp.lua
luafile $HOME/.config/nvim/lsp/bash.lua
luafile $HOME/.config/nvim/lsp/docker.lua
luafile $HOME/.config/nvim/lsp/python.lua
luafile $HOME/.config/nvim/lsp/typescript.lua

" Themes
source $HOME/.config/nvim/themes/onedark.vim
source $HOME/.config/nvim/themes/airline.vim
