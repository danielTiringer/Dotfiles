local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/autoload/plugged')

    -- Look-and-feel plugins
    -- File Explorer
    Plug 'kyazdani42/nvim-web-devicons' -- for file icons
    Plug 'kyazdani42/nvim-tree.lua'
    -- Airline status bar
    Plug 'vim-airline/vim-airline'
    -- Plug 'vim-airline/vim-airline-themes'
    -- Colorscheme
    Plug 'joshdick/onedark.vim'

    -- Coding related plugins
    -- Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    -- Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    -- Language server
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'mfussenegger/nvim-jdtls'
    -- FZF
    Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install']})
    Plug 'airblade/vim-rooter' -- Scopes FZF to the closest upstream git repository
    -- Git
    Plug 'tpope/vim-fugitive'
    -- Comment helper
    Plug 'tpope/vim-commentary'
    -- Surround helper and repeater, so surround can be done multiple times
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    -- Java
    Plug 'nvim-treesitter/nvim-treesitter'

vim.call('plug#end')
