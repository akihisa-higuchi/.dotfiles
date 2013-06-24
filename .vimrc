autocmd!

set nocompatible

let s:is_win = has('win32') || has('win64')
let s:is_mac = !s:is_win && (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')

" NeoBundle:"{{{
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc()

NeoBundleLazy 'Shougo/neocomplcache', { 'autoload' : {
            \ 'insert' : 1
            \ }}

NeoBundleLazy 'Shougo/neosnippet', { 'autoload' : {
            \ 'insert' : 1
            \ }}

NeoBundle 'Shougo/unite.vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'scrooloose/syntastic'
"}}}

scriptencoding utf-8
filetype plugin indent on

" Encoding:"{{{
if !has('gui_running') && s:is_win
    set termencoding=cp932
else
    set termencoding=utf-8
endif

set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos,mac
set ambiwidth=double
"}}}

set history=100
set nobackup

" Format:"{{{
set tabstop=4 shiftwidth=4 softtabstop=0
set smarttab
set expandtab
set shiftround
set autoindent
set smartindent
"}}}

" Search:"{{{
set ignorecase
set smartcase
set hlsearch
set incsearch
"}}}

" Interface:"{{{
augroup highlightIdegraphicSpace
    autocmd!
    autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

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
"}}}

" help
nnoremap <C-h> :<C-u>help<Space>

" help current keyword
nnoremap <C-h><C-h> :<C-u>help<Space><C-r><C-w><CR>

nnoremap j gj
onoremap j gj
xnoremap j gj
nnoremap k gk
onoremap k gk
xnoremap k gk

" Clipboard
set clipboard=unnamed,autoselect
if s:is_mac
    vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
    nmap <Space><C-v> :call setreg("\"",system("pbpaste"))<CR>p
endif

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

" neocomplcache
let bundle = neobundle#get('neocomplcache')
function! bundle.hooks.on_source(bundle)
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_smart_case = 1

    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
endfunction

" neosnippet
let bundle = neobundle#get('neosnippet')
function! bundle.hooks.on_source(bundle)
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

    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
endfunction

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_auto_jump=1

""}}}

