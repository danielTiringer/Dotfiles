"          _
" __    __(_)_ __  __  _ __  ___
" \ \  / /  | '_  '_ \| '__ /  _|
"  \ \/ / | | | | | | | |  |  (_
"   \__/  |_|_| |_| |_|_|   \___|




" Setup for Vundle plugin manager
" ==================================================================

	set nocompatible              " be iMproved, required
	filetype off                  " required

	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	  Plugin 'VundleVim/Vundle.vim'

	" Surround command variants
		Plugin 'tpope/vim-surround'

	"	Plugins (e.g. surround) to use dot
		Plugin 'tpope/vim-repeat'

	"	Plugin to comment out lines or paragraph
		Plugin 'tpope/vim-commentary'

	" Nerdtree, file manager for Vim
	  Plugin 'scrooloose/nerdtree'

	" ALE, linting multiple coding languages
		Plugin 'dense-analysis/ale'

	" Vim Airline
	  Plugin 'vim-airline/vim-airline'
		Plugin 'vim-airline/vim-airline-themes'

	" Solarized plugin to change the default colors
		Plugin 'altercation/vim-colors-solarized'

	" Plugin for Vue.JS
		Plugin 'posva/vim-vue'

	"	Plugin for React
		Plugin 'maxmellon/vim-jsx-pretty'

	" Plugin for Ruby and Rails
	"	Plugin 'vim-ruby/vim-ruby'
		Plugin 'tpope/vim-rails'

	" PHP plugins
		Plugin 'StanAngeloff/php.vim'
		Plugin 'jwalton512/vim-blade'
		Plugin '2072/PHP-Indenting-for-VIm'

	"	Go plugin
		Plugin 'fatih/vim-go'

	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	"
	" Brief help
	" :PluginList       - lists configured plugins
	" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
	" :PluginSearch foo - searches for foo; append `!` to refresh local cache
	" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
	"
	" see :h vundle for more details or wiki for FAQ
	" Put your non-Plugin stuff after this line


" Basics and keybinds
" ==================================================================

"	Setting the numbers on the side relative
	set number relativenumber
" Splits open on the bottom and the right
	set splitbelow splitright

	syntax enable
	syntax on
	set nocompatible
	filetype plugin on

"	Split navigation shortcuts
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

"	CTRL-n opens NerdTree
	nmap <C-n> :NERDTreeToggle<CR>
" NerdTree shows hidden
	let NERDTreeShowHidden=1

" 	Enable poweline fonts
	let g:airline_powerline_fonts = 1

	if !exists('g:airline_symbols')
 	  let g:airline_symbols = {}
	endif

" Unicode symbols
	let g:airline_left_sep = '»'
	let g:airline_left_sep = '▶'
	let g:airline_right_sep = '«'
	let g:airline_right_sep = '◀'
	let g:airline_symbols.linenr = '␊'
	let g:airline_symbols.linenr = '␤'
	let g:airline_symbols.linenr = '¶'
	let g:airline_symbols.branch = '⎇'
	let g:airline_symbols.paste = 'ρ'
	let g:airline_symbols.paste = 'Þ'
	let g:airline_symbols.paste = '∥'
	let g:airline_symbols.whitespace = 'Ξ'

" Airline symbols
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ''

"	Copy and paste to and from Vim
	vnoremap <C-c> "+y
	map <C-v> "+P

"	Setting tab to 2 spaces worth, indent to 2 spaces, tab to the next indent
	set tabstop=2 shiftwidth=2 smarttab

" Deleting traling whitespace from documents
	autocmd BufWritePre * %s/\s\+$//e

"	Disabling the arrows. Learn the hard way.
	noremap <Up> <Nop>
	noremap <Down> <Nop>
	noremap <Left> <Nop>
	noremap <Right> <Nop>
	inoremap <Up> <Nop>
	inoremap <Down> <Nop>
	inoremap <Left> <Nop>
	inoremap <Right> <Nop>

"	Because I mess it up all the time
	command! Wq wq
	command! WQ wq
	command! W w
	command! Q q

" Programming language specific settings
" =================================================================

"	Go
	au BufRead,BufNewFile *.go set filetype=go

"	Typescript
	au BufRead,BufNewFile *.ts setfiletype typescript
	au BufNewFile *.ts 0r ~/.vim/templates/skeleton.ts

" Javascript
  set autoindent
  filetype plugin indent on
  autocmd FileType javascript setlocal smartindent
	au BufNewFile,BufRead *.ejs set filetype=html
  inoremap {<CR> {<CR>}<ESC>O
  inoremap (<CR> (<CR>)<ESC>O
  inoremap [<CR> [<CR>]<ESC>O

"	Vue JS
	au BufNewFile *.vue 0r ~/.vim/templates/skeleton.vue

	au BufNewFile,BufRead *.vue setlocal filetype=vue
	let g:vue_disable_pre_processors=1
	autocmd FileType vue syntax sync fromstart

  autocmd FileType vue inoremap ,te <template><Enter><Enter></template><Esc>ki
  autocmd FileType vue inoremap ,sc <scipt><Enter>export default {<Enter><Enter>}<Enter></script><Esc>2ki
  autocmd FileType vue inoremap ,st <style scoped><Enter><Enter></style><Esc>ki

"	Ruby
	autocmd FileType eruby syntax sync fromstart
  autocmd FileType eruby setlocal smartindent
	au BufNewFile *.erb 0r ~/.vim/templates/skeleton.html
	autocmd FileType eruby inoremap ,def def<Enter><Enter>end<Esc>2k$a<Space>
	autocmd FileType eruby inoremap ,if if<Enter><Enter>end<Esc>2k$a<Space>
	autocmd FileType eruby inoremap ,% <%<Space>%><Enter><Enter><%<Space>end<Space>%><Esc>2k$F%hi<Space>
	autocmd FileType eruby inoremap ,%= <%=<Space>%><Enter><Enter><%<Space>end<Space>%><Esc>2k$F%hi<Space>

"	HTML
	au BufNewFile *.html 0r ~/.vim/templates/skeleton.html

  autocmd FileType html,vue,eruby,php inoremap ,1 <h1></h1><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,2 <h2></h2><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,3 <h3></h3><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,4 <h4></h4><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,5 <h5></h5><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,6 <h6></h6><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,a <a<Space>href=""></a><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,as <aside><Enter></aside><Esc>O
  autocmd FileType html,vue,eruby,php inoremap ,b <b></b><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,d <div><Enter></div><Esc>O
  autocmd FileType html,vue,eruby,php inoremap ,f <form><Enter></form><Esc>O
  autocmd FileType html,vue,eruby,php inoremap ,i <i<Space>class=""></i><Esc>F"i
  autocmd FileType html,vue,eruby,php inoremap ,im <img src="" alt=""><Esc>%f"a
  autocmd FileType html,vue,eruby,php inoremap ,in <input type="" id="" name="" value="" required>
  autocmd FileType html,vue,eruby,php inoremap ,li <Esc>o<li></li><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,m <main><Enter></main><Esc>O
  autocmd FileType html,vue,eruby,php inoremap ,n <nav></nav><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,op <Esc>o<option value=""></option><Esc>F<i
  autocmd FileType html,vue,eruby,php inoremap ,p <p></p><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,s <session></session><Esc>%i
  autocmd FileType html,vue,eruby,php inoremap ,se <select><Enter><option value=""></option><Enter></select><Enter><Enter><Esc>3k%a
  autocmd FileType html,vue,eruby,php inoremap ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><Esc>03k%a
  autocmd FileType html,vue,eruby,php inoremap ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><Esc>03k%a
  autocmd FileType html,vue,eruby,php inoremap ,tab <table><Enter></table><Esc>O
  autocmd FileType html,vue,eruby,php inoremap ,td <td></td><Esc>Fdcit
  autocmd FileType html,vue,eruby,php inoremap ,tr <tr></tr><Enter><Esc>kf<i
  autocmd FileType html,vue,eruby,php inoremap ,th <th></th><Esc>Fhcit
  autocmd FileType html,vue,eruby,php inoremap ,dt <dt></dt><Enter><dd></dd><Enter><esc>2kcit
  autocmd FileType html,vue,eruby,php inoremap ,dl <dl><Enter><Enter></dl><enter><enter><esc>3kcc

" Color scheme
" ============
	colorscheme solarized
	let g:solarized_termtrans=1
"	This setting removes the dark background from most of the letters.
	set bg=dark
"	This setting makes the background transparent
	hi Normal guibg=NONE ctermbg=NONE
