let s:darwin = system('uname') =~? '^darwin'

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mattn/emmet-vim'
Plug 'dense-analysis/ale'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

call plug#end()
"}}}

set encoding=utf-8

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
set hidden
set lazyredraw
set backspace=indent,eol,start
set wildmode=list:full
set list
set listchars=tab:>\ \,trail:-
set laststatus=2
set statusline=%<%n:\ %F\ %m%r%w%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}%=%L(%P)
set title
let &titlestring = hostname() . expand("%:p")
set ambiwidth=double

colorscheme desert
"}}}

" Clipboard {{{
set clipboard=unnamed,autoselect
if s:darwin
	vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
endif
"}}}

" NERDTree {{{
map <C-n> :NERDTreeToggle<CR>
"}}}

" EasyAlign {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}

