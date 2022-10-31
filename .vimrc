" load ----------------------------------------
source <sfile>:h/functions.vim
source <sfile>:h/plugin_settings.vim
source <sfile>:h/keymap.vim

" base ----------------------------------------
set noswapfile
set clipboard+=unnamed
set tabstop=4
set backspace=indent,eol,start
"set ff=unix
"set fileencoding=utf8

" fold ----------------------------------------
set foldmethod=indent
set foldlevel=4
set foldcolumn=3

" looks ---------------------------------------
syntax on
set number
set cursorline
set cursorcolumn
set ambiwidth=double
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
colorscheme torte
call ChangeColor()

" status line ---------------------------------
set ruler
set laststatus=2
set statusline=%F%m%r%h%w%=[all]_%p%%__[row]_%l/%L__[col]_%02v__[%{&fenc!=''?&fenc:&enc}]
let ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR' }
set statusline+=[%{ff_table[&ff]}]

" explorer ------------------------------------
set splitright
filetype plugin on
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 70

" search jump ---------------------------------
set hlsearch
set incsearch
au QuickFixCmdPost *grep* cwindow

" completion ----------------------------------
set dictionary+=./dictionary.dat
set thesaurus+=./dictionary.dat
set wildmenu
set complete=.,w,b,u,U,k,kspell,s,i,d,t
set completeopt=menuone,noinsert,preview,popup

" ini -----------------------------------------
if has('vim_starting')
  cd
endif
call timer_start(18000, { -> Timer() }, {'repeat': -1})
