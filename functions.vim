" timer ---------------------------------------
let s:ini_hour = localtime() / 3600
function! Timer()
  let l:now_hour = localtime() / 3600
  if now_hour != s:ini_hour
    let s:ini_hour = now_hour
    call ChangeColor()
    call popup_create([
          \ strftime('%Y/%m/%d %H:%M (%A)', localtime()),
          \ '',
          \ 'colorscheme: ' . execute('colorscheme')
          \],
          \ #{border: [], zindex: 999, time: 3500})
    call timer_start(1000, { -> RunCat() })
  endif
endfunction

" change color --------------------------------
let s:colorscheme_arr = [
      \ 'onedark',
      \ 'onehalfdark',
      \ 'hybrid_material',
      \ 'molokai',
      \ 'gruvbox',
      \ 'jellybeans',
      \ 'materialbox',
      \ 'afterglow',
      \ 'alduin',
      \ 'apprentice'
      \ ]
function! ChangeColor()
  if glob('~/.vim/pack/plugins/start') != ''
    execute('colorscheme ' . s:colorscheme_arr[localtime() % len(s:colorscheme_arr)])
  endif
endfunction

" grep ----------------------------------------
function! GrepCurrentExtention()
  echo 'grep processing in [' . expand('%:e') .'] ...'
  execute('vimgrep /' . expand('<cword>') . '/gj **/*.' . expand('%:e'))
endfunction

command! -nargs=1 GrepExtFrom call GrepExtFrom(<f-args>)
function! GrepExtFrom(ext)
  echo 'grep processing in [' . a:ext .'] ...'
  execute('vimgrep /' . expand('<cword>') . '/gj **/*.' . a:ext)
endfunction

" mark ----------------------------------------
function! Marking() abort
  let l:now_marks = []
  let l:words = 'abcdefghijklmnopqrstuvwxyz'
  let l:warr = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        \ 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
  for row in split(execute('marks'), '\n')
    let l:r = filter(split(row, ' '), {i, v -> v != ''})
    if stridx(words, r[0]) != -1 && r[1] == line('.')
      execute('delmarks ' . r[0])
      echo 'delete mark'
      return
    endif
    let l:now_marks = add(now_marks, r[0])
  endfor
  let l:can_use = filter(warr, {i, v -> stridx(join(now_marks, ''), v) == -1})
  if len(can_use) != 0
    execute('mark ' . can_use[0])
    echo 'marked'
  else
    echo 'over limit markable char'
  endif
endfunction

" buffer --------------------------------------
function! CloseBuf()
  let l:now_b = bufnr('%')
  bn
  execute('bd ' . now_b)
endfunction

" terminal ------------------------------------
function! TerminalPop()
  call popup_create(
        \ term_start([&shell], #{ hidden: 1, term_finish: 'close'}),
        \ #{ border: [], minwidth: &columns/2, minheight: &lines/2 })
endfunction

" favorite  -----------------------------------
command! -nargs=* Necronomicon call Necronomicon(<f-args>)
function! Necronomicon(...) abort
  if a:0 == 0
    e ~/.uranometria/necronomicon.md
    loadview
    return
  elseif a:0 == 1 && a:1 == 'YogSothoth'
    execute('!sh ~/.uranometria/forge/backup.sh')
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

function! RunCat()
  let l:delay = 250
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

