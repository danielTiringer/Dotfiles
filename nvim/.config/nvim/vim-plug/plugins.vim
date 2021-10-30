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
    " Stable version of coc and its extensions
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
    Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
    Plug 'neoclide/coc-snippets',  {'do': 'yarn install --frozen-lockfile'}


call plug#end()
