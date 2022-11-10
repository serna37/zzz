" startify ----------------------------------
let g:startify_change_to_dir = 0

" airline ----------------------------------
let g:airline_theme = 'deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_highlighting_cache = 1

" explorer ---------------------------------
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1

" search -----------------------------------
set rtp+=~/.vim/pack/plugins/start/fzf
let g:ctrlp_map = '<>'
let g:ctrlp_working_path_mode = 'w'

" motion -----------------------------------
let g:comfortable_motion_interval = 1000.0 / 60
let g:comfortable_motion_friction = 80.0
let g:comfortable_motion_air_drag = 5.0

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys='wasdqerfjklionm'

" zen --------------------------------------
let g:goyo_width = 100
let g:limelight_conceal_ctermfg = 'DarkGray'
au User GoyoEnter Limelight
au User GoyoLeave Limelight!

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
