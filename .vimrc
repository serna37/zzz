" ini -------------------------------------------------------------
if has('vim_starting')
  cd
endif
let s:timer = timer_start(18000, { -> Timer() }, {'repeat': -1})
let s:ini_hour = localtime() / 3600
function! Timer()
  let l:now_hour = localtime() / 3600
  if now_hour != s:ini_hour
    let s:ini_hour = now_hour
    call ChangeColor()
    let _ = popup_create([strftime('%Y/%m/%d %H:%M (%A)', localtime()), '', 'colorscheme: ' . execute('colorscheme')], #{border: [], zindex: 999, time: 3500})
    call timer_start(1000, { -> RunCat() })
  endif
endfunction

" base ----------------------------------------
let g:mapleader = "\<Space>"
set noswapfile
set clipboard+=unnamed
set tabstop=4
set backspace=indent,eol,start
"set ff=unix
"set fileencoding=utf8

" looks -------------------------------------------------------
syntax on
set number
set cursorline
set cursorcolumn
set ambiwidth=double
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
colorscheme torte
let s:colorscheme_arr = ['onedark', 'deus', 'molokai', 'dogrun', 'space-vim-dark', 'jellybeans', 'lucius']
let g:limelight_conceal_ctermfg = 'DarkGray'
function! ChangeColor()
  if glob('~/.vim/pack/plugins/start/awesome-vim-colorschemes') != ''
    execute('colorscheme ' . s:colorscheme_arr[localtime() % len(s:colorscheme_arr)])
  endif
endfunction
call ChangeColor()
nmap <Leader><Leader>c :call ChangeColor()<CR>:colorscheme<CR>
nmap <Leader>s :Limelight!!<CR>

" status/tab line ---------------------------------------------------
set ruler
set laststatus=2
set statusline=%F%m%r%h%w%=[all]_%p%%___[row]_%l/%L___[col]_%02v___[%{&fenc!=''?&fenc:&enc}]
let ff_table = {'dos' : 'CRLF', 'unix' : 'LF', 'mac' : 'CR' }
set statusline+=[%{ff_table[&ff]}]
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" explorer -------------------------------------------
set splitright
filetype plugin on
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 70
let NERDTreeShowBookmarks = 1
nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader><Leader>e :NERDTreeFind<CR>zz
if glob('~/.vim/pack/plugins/start/nerdtree') == ''
  nmap <Leader>e :30Ve<CR>
endif

" search find ---------------------------------------------------
command! -nargs=1 Q call FileSearch(<f-args>)
function! FileSearch(name)
  for found in split(glob(a:name), "\n")
    echo found
  endfor
endfunction
set rtp+=~/.vim/pack/plugins/start/fzf
nmap <Leader>f :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>

" programer jump grep info -------------------------------------------
set hlsearch
set incsearch
autocmd QuickFixCmdPost *grep* cwindow
nmap <Leader>gg :call GrepCurrentExtention()<CR>
function! GrepCurrentExtention()
  echo 'grep processing in [' . expand('%:e') .'] ...'
  call execute('vimgrep /' . expand('<cword>') . '/gj **/*.' . expand('%:e'))
endfunction
nmap <Leader>ge :GrepExtFrom 
command! -nargs=1 GrepExtFrom call GrepExtFrom(<f-args>)
function! GrepExtFrom(ext)
  echo 'grep processing in [' . a:ext .'] ...'
  call execute('vimgrep /' . expand('<cword>') . '/gj **/*.' . a:ext)
endfunction
nmap <Leader>j :LspHover<CR>
nmap <Leader>p :LspPeekDefinition<CR>
nmap <Leader>o :LspDefinition<CR>
nmap <Leader>r :LspReferences<CR>

" god speed jump -------------------------------------------------------
let g:comfortable_motion_interval = 2400.0 / 60
let g:comfortable_motion_friction = 100.0
let g:comfortable_motion_air_drag = 3.0
nmap <Leader>w <Plug>(easymotion-overwin-f2)
nmap <Leader>m :marks abcdefghijklmnopqrstuvwxyz<CR>:normal! `
nmap mm :call Marking()<CR>
function! Marking() abort
  let l:now_marks = []
  let l:words = 'abcdefghijklmnopqrstuvwxyz'
  let l:warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
  for row in split(execute('marks'), '\n')
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    if stridx(words, r[0]) != -1 && r[1] == line('.')
      call execute('delmarks ' . r[0])
      echo 'delete mark'
      return
    endif
    let l:now_marks = add(now_marks, r[0])
  endfor
  let l:can_use = filter(warr, {i, v -> stridx(join(now_marks, ''), v) == -1})
  if len(can_use) != 0
    call execute('mark ' . can_use[0])
    echo 'marked'
  else
    echo 'over limit markable char'
  endif
endfunction

" window change open close zen ------------------------------------------
nmap <C-p> :bn<CR>
nmap <C-q> :bp<CR>
nmap <Leader>x :call CloseBuf()<CR>
function! CloseBuf()
  let l:now_b = bufnr('%')
  bn
  execute('bd ' . now_b)
endfunction
nmap <Leader>t :call popup_create(term_start([&shell], #{ hidden: 1, term_finish: 'close'}), #{ border: [], minwidth: winwidth(0)/2, minheight: &lines/2 })<CR>
let g:goyo_width = 100
nmap <Leader>z :Goyo<CR>:set number<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" completion ----------------------------------------------------
set dictionary+=~/.uranometria/forge/dictionary_english.dat
set thesaurus+=~/.uranometria/forge/dictionary_english.dat
set dictionary+=~/.uranometria/necronomicon.md
set thesaurus+=~/.uranometria/necronomicon.md
set wildmenu
set complete=.,w,b,u,U,k,kspell,s,i,d,t
set completeopt=menuone,noinsert,preview,popup
let g:vsnip_snippet_dir = '~/.uranometria/forge/snips'
nmap <Leader>0 :VsnipOpen<CR>
imap <expr> <Tab> pumvisible() ? '<C-n>' : vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-n>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap ` ``<LEFT>
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'dictionary',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#dictionary#completor'),
    \ })
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#around#get_source_options({
    \ 'name': 'around',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#around#completor'),
    \ }))

" other -------------------------------------------------------------
nmap <Leader>l :call ExecuteThisLineCMD()<CR>
function! ExecuteThisLineCMD()
  execute('bo terminal ++shell eval ' . getline('.'))
endfunction
nmap <Leader>n :Necronomicon 
command! -nargs=* Necronomicon call Necronomicon(<f-args>)
function! Necronomicon(...) abort
  if a:0 == 0
    e ~/.uranometria/necronomicon.md
    return
  elseif a:0 == 1 && a:1 == 'YogSothoth'
    call execute('!sh ~/.uranometria/forge/backup.sh', '')
    return
  elseif a:0 == 2 && a:1 == 'Azathoth' && a:2 == 'kill'
    bo terminal ++shell ++close sh ~/.uranometria/forge/kill.sh
    smile
    return
  elseif a:0 == 1 && a:1 == 'Azathoth'
    bo terminal ++shell ++close sh ~/.uranometria/forge/omnibus.sh
    smile
    return
  endif
endfunction

nmap <Leader><Leader>w :call RunCat()<CR>
function! RunCat()
  let l:delay = 300
  call timer_start(delay * 0, { -> popup_create(s:running_cat[0], #{border: [], time: delay}) })
  call timer_start(delay * 1, { -> popup_create(s:running_cat[1], #{border: [], time: delay}) })
  call timer_start(delay * 2, { -> popup_create(s:running_cat[2], #{border: [], time: delay}) })
  call timer_start(delay * 3, { -> popup_create(s:running_cat[3], #{border: [], time: delay}) })
  call timer_start(delay * 4, { -> popup_create(s:running_cat[4], #{border: [], time: delay}) })
  call timer_start(delay * 5, { -> popup_create(s:running_cat[0], #{border: [], time: delay}) })
  call timer_start(delay * 6, { -> popup_create(s:running_cat[1], #{border: [], time: delay}) })
  call timer_start(delay * 7, { -> popup_create(s:running_cat[2], #{border: [], time: delay}) })
  call timer_start(delay * 8, { -> popup_create(s:running_cat[3], #{border: [], time: delay}) })
  call timer_start(delay * 9, { -> popup_create(s:running_cat[4], #{border: [], time: delay}) })
endfunction
let s:running_cat = [
    \[
    \ '                                                            ',
    \ '                               =?7I=~             ~~        ',
    \ '                            =NMMMMMMMMMD+      :+OMO:       ',
    \ '                          ~NMMMMMMMMMMMMMMMNNMMMMMMMM=      ',
    \ '                        :DMMMMMMMMMMMMMMMMMMMMMMMMMMMN=     ',
    \ '                      IMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8:     ',
    \ '                  :$MMMMMMMMMMMMMMMMMMMMMMMMMMMM?           ',
    \ '             :~ZMMMMMNI :DMMMMMMMMMMMMMMMMMNN$:             ',
    \ '       :+8NMMMMMMMO~     =NMMMMMMM?  +MMD~                  ',
    \ '     8MMMMMMM8+:           :?OMMMM+ =NMM~                   ',
    \ '                             :DMMZ  7MM+                    ',
    \ '                              ?NMMMMMMD:                    ',
    \ '                                 :?777~                     ',
    \],
    \[
    \ '                                                            ',
    \ '                                                     :O~    ',
    \ '                                          +I777ZDNMMMMMI    ',
    \ '                        :+Z8DDDNNNNDD88NMMMMMMMMMMMMMMMM$   ',
    \ '                     +DMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM=  ',
    \ '                  :$MMMMMMMMMMMMMMMMMMMMMMMMMMMMMN888DMM8:  ',
    \ '                :OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMD            ',
    \ '              ?NMMMMMMMMMMMMMMMMMMMMMMMMD?~=DMMMI           ',
    \ '    7MMMMMMMMMMMMZ+NMMMMMMMMMNNNNN87?~: +NDDMMN~            ',
    \ '     ~?$OZZI=:   7MMMMMMMMMN=            =DM8:              ',
    \ '                  8MMN888$:                                 ',
    \ '                  :DMMD$                                    ',
    \ '                    =7$=                                    ',
    \],
    \[
    \ '                                                            ',
    \ '                                                            ',
    \ '                         ~~++?????IIIIIIII7$77I?+I$$77OD:   ',
    \ '              ~7ODNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7   ',
    \ '         ~ZNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM?  ',
    \ '      :$MMMMZ=?MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM$  ',
    \ '    =NMM8~  :OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8: :~77   ',
    \ '  =NMM+  :DMMMMMMMMMMMMMN+     :=OMMMMMMMMMMD$8MMMMMD?      ',
    \ ' OMN=  ?NMMMMMMMMMMNZ+::             ::~::      IMMMMMMM$   ',
    \ ' ::  ZMMMMMMN?:                                =MMO:  =$~   ',
    \ '    ~8Z~DMN=                                                ',
    \ '                                                            ',
    \ '                                                            ',
    \],
    \[
    \ '                                                            ',
    \ '                      :IZOZI:                               ',
    \ '                   INMMMMMMMMMD+                     ?:     ',
    \ '                =DMMMMMMMMMMMMMMMM8$II7$OO87:  :=ODDMM+     ',
    \ '             :OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8    ',
    \ '           =NMMD+ 8MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMI   ',
    \ '        :8MMMZ7DDDMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7   ',
    \ '      +NMMM7 ~MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7           ',
    \ '   :7MMMM7   +MMNMMMMM$: :?8NNMMMMMMMMMMNNMMMMMN:           ',
    \ '  =DMMN?    :8MM~  :                      :8MMMMMMMMN8?:    ',
    \ '   =~      8MMM7                             ?8MMMD+?ZNM?   ',
    \ '            +~                                  :$NMMN7     ',
    \ '                                                   :IDD=    ',
    \],
    \[
    \ '                                                            ',
    \ '                            ~~:                             ',
    \ '                        =ONMMMMMMD$~                        ',
    \ '                     +8MMMMMMMMMMMMMNZ:           :         ',
    \ '                  ~8MMMMMMMMMMMMMMMMMMMMDD8DDDNDDM8         ',
    \ '               =OMMMM$DMMMMMMMMMMMMMMMMMMMMMMMMMMMM+        ',
    \ '           :OMMMMNI:  NMMMMMMM$ZNMMMMMMMMMMMMMMMMMM8:       ',
    \ '        ~DMMMNI:    :NMMMMMMMZ   =NMMMMMMMMMMMMMMMMM=       ',
    \ '      =NMMN+         OMMMMMD~      :ZNMMMMMMMMO  :+:        ',
    \ '      :?=:            +MM?            7MM8 +NMMMI:          ',
    \ '                       :NM8=           ZM$    :ZNMMMD       ',
    \ '                         ?$=           :DMO:       II       ',
    \ '                                        :I+                 ',
    \]
\]

