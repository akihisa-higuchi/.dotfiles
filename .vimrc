set nocompatible

let s:is_win = has('win32') || has('win64')
let s:is_mac = system('uname') =~? '^darwin'

filetype plugin indent on

" vim-plug {{{
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/syntastic'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'jelera/vim-javascript-syntax'

call plug#end()
"}}}

syntax enable


" Encoding {{{
set encoding=utf-8
set termencoding=utf-8
set fileformat=unix
set fileformats=unix,dos,mac
set ambiwidth=double
"}}}

" Format {{{
set autoindent
set smartindent
"}}}

" Search {{{
set ignorecase
set smartcase
set hlsearch
set incsearch
"}}}

" Interface {{{
set number
set backspace=eol,indent,start
set showmatch
set matchpairs+=<:>
set hidden
set list
set listchars=tab:>\ \,trail:-,extends:>,precedes:<
set laststatus=2
set statusline=%<%n:\ %F\ %m%r%w%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}%=%L(%P)
set title
let &titlestring = hostname() . expand("%:p")
set wildmode=list:full
set report=0

augroup highlightIdegraphicSpace
	autocmd!
	autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
	autocmd VimEnter,WinEnter * call matchadd("IdeographicSpace", '\%u3000')
augroup END

colorscheme desert
"}}}

" Clipboard {{{
set clipboard=unnamed,autoselect
if s:is_mac
	vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
endif
"}}}

" Plugin {{{

" NERDTree {{{
map <C-n> :NERDTreeToggle<CR>
"}}}

" syntastic {{{
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes': ['php'],
	\ 'passive_filetypes': ['html'] }
"}}}

"}}}

