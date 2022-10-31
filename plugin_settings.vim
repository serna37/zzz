" airline ----------------------------------
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache=1

" explorer ---------------------------------
let g:NERDTreeShowBookmarks = 1

" search -----------------------------------
set rtp+=~/.vim/pack/plugins/start/fzf

" motion -----------------------------------
let g:comfortable_motion_interval = 1000.0 / 60
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 5.0

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys='wasdqerfjklionm'

" zen --------------------------------------
let g:goyo_width = 100
let g:limelight_conceal_ctermfg = 'DarkGray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" completion --------------------------------
let g:vsnip_snippet_dir = '~/.uranometria/forge/snips'

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
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

