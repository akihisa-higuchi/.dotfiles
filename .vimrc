autocmd!

set nocompatible

let s:iswin = has('win32') || has('win64')
let $DOTVIM = expand('~/.vim')

" NeoBundle:"{{{
if has('vim_starting')
    execute 'set runtimepath+=' . $DOTVIM . '/neobundle.vim.git'
endif

filetype off

call neobundle#rc($DOTVIM . '/.bundle')

NeoBundle 'git://github.com/tpope/vim-surround.git'
NeoBundle 'git://github.com/tpope/vim-repeat.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/mattn/zencoding-vim.git'
"}}}

filetype plugin indent on

" Encoding:"{{{
if !has('gui_running') && s:iswin
    set termencoding=cp932
else
    set termencoding=utf-8
endif

set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos,mac
set ambiwidth=double

command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Eucjp edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932 edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Sjis  Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Jis  Iso2022jp<bang> <args>

command! Ceutf8 setlocal fenc=utf-8
command! Ceeucjp setlocal fenc=euc-jp
command! Cecp932 setlocal fenc=cp932
command! Ceiso2022jp setlocal fenc=iso-2022-jp
command! Cesjis ceCp932
command! Cejis ceIso2002jp
"}}}

set history=100
set nowritebackup
set nobackup
set clipboard=unnamed,autoselect

" Format:"{{{
set tabstop=4 shiftwidth=4 softtabstop=0
set smarttab
set expandtab
set shiftround
set modeline
set autoindent
set smartindent
"}}}

" Search:"{{{
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
"}}}

" Interface:"{{{
set background=dark
if has('syntax')
    syntax enable
    colorscheme desert
endif

set number
set ruler
set backspace=eol,indent,start
set showmatch
set matchtime=3
set matchpairs+=<:>
set hidden
set list
set listchars=tab:>-,trail:_,extends:>,precedes:<
set wrap
set whichwrap=b,s,h,l,<,>,~,[,]
set laststatus=2
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B)\ %l/%L(%P)%m
set showcmd
set title
let &titlestring = hostname() . expand("%:p")
set wildmode=list:full
set wildignore+=*.DS_Store
set visualbell
set report=0
set mouse=a
"}}}

" vimrc edit/reload
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC<CR>

" help
nnoremap <C-h> :<C-u>help<Space>
" help current keyword
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

noremap j  gj
noremap k  gk
noremap gj  j
noremap gk  k

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>

" Commet out
vnoremap co/ :s/^/\/\//<CR>:nohlsearch<CR>
vnoremap co# :s/^/#/<CR>:nohlsearch<CR>
vnoremap co" :s/^/\"/<CR>:nohlsearch<CR>
vnoremap cod :s/^\/\/\\|^[#"]//<CR>:nohlsearch<CR>
vnoremap co* v`<I<CR><esc>k0i/*<ESC>`>j0i*/<CR><esc><ESC>
vnoremap co< v`<I<CR><esc>k0i<!--<ESC>`>j0i--><CR><esc><ESC>

" Complement Date and Time
inoremap <expr> ,df  strftime('%Y-%m-%dT%H:%M:%S')
inoremap <expr> ,dd  strftime('%Y-%m-%d')
inoremap <expr> ,dt  strftime('%H:%M:%S')

" Registers and Marks
nnoremap <Space>m :<C-u>marks
nnoremap <Space>r ;<C-u>registers

" Select the latest change text
nnoremap gc  `[v`]
vnoremap gc  :<C-u>normal gc<CR>
onoremap gc  :<C-u>normal gc<CR>

" Override syntax highlight
autocmd ColorScheme * highlight TabLine cterm=NONE ctermfg=lightgray ctermbg=darkgray
doautocmd ColorScheme _

" Set cursorline only current window
autocmd WinEnter *  setlocal cursorline
autocmd WinLeave *  setlocal nocursorline

"" Completion :cd
command! -complete=customlist,CompleteCD -nargs=? CD  cd <args>
function! CompleteCD(arglead, cmdline, cursorpos)
  let pattern = join(split(a:cmdline, '\s', !0)[1:], ' ') . '*/'
  return split(globpath(&cdpath, pattern), "\n")
endfunction
cnoreabbrev <expr> cd
\ (getcmdtype() == ':' && getcmdline() ==# 'cd') ? 'CD' : 'cd'

" Plugin:"{{{

" neocomplcache.vim
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_enable_cursor_hold_i = 0
let g:neocomplcache_cursor_hold_i_time = 300

let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_max_list = 100
let g:neocomplcache_force_overwrite_completefunc = 1

if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

let g:neocomplcache_snippets_dir = $HOME . '/snippets'

"}}}

