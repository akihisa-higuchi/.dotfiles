set nocompatible
filetype off

let s:iswin = has('win32') || has('win64')

" Vundle"{{{
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

"Bundle 'gmarik/vundle'

" My Bundles here:
"Bundle 'tpope/vim-surround'
"Bundle 'Shougo/neocomplcache'
"Bundle 'Shougo/unite.vim'
"Bundle 'Shougo/vimfiler'
"Bundle 'Shougo/vimproc'
"Bundle 'Shougo/vimshell'
"Bundle 'thinca/vim-quickrun'
"Bundle 'mattn/zencoding-vim'

"}}}

autocmd!

filetype plugin indent on

set enc=utf-8
set tenc=utf-8
set ff=unix
set ffs=unix,dos,mac
set ambiwidth=double
set history=100
set magic

"" Define DOTVIM directory
if has('win32') || has('win64')
    let $DOTVIM=$VIM."/vimfiles"
else
    let $DOTVIM=$HOME."/.vim"
endif

"" Backup
set nowritebackup
set nobackup

"" Colors
set background=dark
if has('syntax')
    syntax enable
    colorscheme desert
endif

"" Text format
set ts=4 sw=4 sts=0
set autoindent
set smartindent
set expandtab
set smarttab
set formatoptions=tcqor

"" Complement
set wildmode=list:full
set wildignore+=*.DS_Store

"" User interface
set number
set ruler
"set cursorline
set backspace=eol,indent,start
set cmdheight=1
set hidden
set list
set listchars=tab:>-,trail:_,extends:>,precedes:<
set mouse=a
set nowrap
set report=0
set scrolloff=5
set showcmd
set showmode
set title
set titlestring=Vim:\ %f\ %h%r%m
set visualbell
set whichwrap=b,s,<,>,[,]
set wildmenu

set laststatus=2
set statusline=%<%F\ %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B)\ %l/%L(%P)%m

"" Search
set ignorecase
set smartcase
set hlsearch
set noincsearch
set nowrapscan

"" vimrc edit/reload
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC<CR>

"" help
nnoremap <C-h> :<C-u>help<Space>
"" help current keyword
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

"" Commet out
vnoremap co/ :s/^/\/\//<CR>:nohlsearch<CR>
vnoremap co# :s/^/#/<CR>:nohlsearch<CR>
vnoremap co" :s/^/\"/<CR>:nohlsearch<CR>
vnoremap cod :s/^\/\/\\|^[#"]//<CR>:nohlsearch<CR>
vnoremap co* v`<I<CR><esc>k0i/*<ESC>`>j0i*/<CR><esc><ESC>
vnoremap co< v`<I<CR><esc>k0i<!--<ESC>`>j0i--><CR><esc><ESC>

"" Complement Date and Time
inoremap <expr> ,df  strftime('%Y-%m-%dT%H:%M:%S')
inoremap <expr> ,dd  strftime('%Y-%m-%d')
inoremap <expr> ,dt  strftime('%H:%M:%S')

"" Registers and Marks
nnoremap <Space>m :<C-u>marks
nnoremap <Space>r ;<C-u>registers

"" 最後に変更したテキストの選択
nnoremap gc  `[v`]
vnoremap gc  :<C-u>normal gc<CR>
onoremap gc  :<C-u>normal gc<CR>

"" Override syntax highlight
autocmd ColorScheme * highlight TabLine cterm=NONE ctermfg=lightgray ctermbg=darkgray
doautocmd ColorScheme _

" カレントウィンドウのカーソル行をハイライトする
autocmd WinEnter *  setlocal cursorline
autocmd WinLeave *  setlocal nocursorline

"" Reload with encoding command
command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Eucjp edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Cp932 edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
command! -bang -bar -complete=file -nargs=? Sjis  Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Jis  Iso2022jp<bang> <args>

"" Set file encording
command! Ceutf8 setlocal fenc=utf-8
command! Ceeucjp setlocal fenc=euc-jp
command! Cecp932 setlocal fenc=cp932
command! Ceiso2022jp setlocal fenc=iso-2022-jp
command! Cesjis ceCp932
command! Cejis ceIso2002jp

"" Completion :cd
command! -complete=customlist,CompleteCD -nargs=? CD  cd <args>
function! CompleteCD(arglead, cmdline, cursorpos)
  let pattern = join(split(a:cmdline, '\s', !0)[1:], ' ') . '*/'
  return split(globpath(&cdpath, pattern), "\n")
endfunction
cnoreabbrev <expr> cd
\ (getcmdtype() == ':' && getcmdline() ==# 'cd') ? 'CD' : 'cd'

