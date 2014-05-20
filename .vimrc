set nocompatible

let s:is_win = has('win32') || has('win64')
let s:is_mac = system('uname') =~? '^darwin'

" NeoBundle {{{

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin()

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
	\ 'build' : {
	\ 	'windows' : 'make -f make_mingw32.mak',
	\ 	'cygwin' : 'make -f make_cygwin.mak',
	\ 	'mac' : 'make -f make_mac.mak',
	\ 	'unix' : 'make -f make_unix.mak',
	\ 	},
	\ }

NeoBundleLazy 'Shougo/unite.vim', { 'autoload' : {
	\ 'commands' : [{ 'name' : 'Unite',
	\ 	'complete' : 'customlist,unite#complete_source'},
	\ 	'UniteWithCursorWord', 'UniteWithInput']
	\ }}

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'othree/html5.vim'

call neobundle#end()

"}}}

filetype plugin indent on

syntax enable

NeoBundleCheck

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

" neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1

if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"}}}

" neosnippet {{{
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)"
	\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)"
	\: "\<TAB>"

if has('conceal')
	set conceallevel=2 concealcursor=i
endif
"}}}

" syntastic {{{
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes': ['php'],
	\ 'passive_filetypes': ['html'] }
"}}}

"}}}

