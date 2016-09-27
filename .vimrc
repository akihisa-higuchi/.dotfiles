let s:darwin = system('uname') =~? '^darwin'

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
Plug 'honza/dockerfile.vim'
Plug 'scrooloose/syntastic'

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

augroup highlightIdeographicSpace
	autocmd!
	autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
	autocmd VimEnter,WinEnter * call matchadd("IdeographicSpace", '\%u3000')
augroup END

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

" syntastic {{{
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes': ['php'],
	\ 'passive_filetypes': ['html'] }
"}}}

" EasyAlign {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}

