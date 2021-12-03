" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Look-and-feel plugins
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Airline status bar
    Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    " Colorscheme
    Plug 'joshdick/onedark.vim'

    " Coding related plugins
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Language server
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'mfussenegger/nvim-jdtls'
    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter' " Scopes FZF to the closest upstream git repository
    " Git
    Plug 'tpope/vim-fugitive'
    " Comment helper
    Plug 'tpope/vim-commentary'
    " Surround helper
    Plug 'tpope/vim-surround'
    " Java
    Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()
