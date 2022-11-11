" base ---------------------------------------
let g:mapleader = "\<Space>"

" exploere  ---------------------------------------
nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader><Leader>e :NERDTreeFind<CR>zz

" file search ---------------------------------------
nmap <Leader>f :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
if has('win32unix')
  nmap <Leader>f :CtrlP<CR>
  nmap <Leader>b :CtrlPBuffer<CR>
  nmap <Leader>h :CtrlPMRUFiles<CR>
endif

" search ---------------------------------------
nmap <Leader>gg :call GrepCurrentExtention()<CR>
nmap <Leader>ge :GrepExtFrom 

nmap <Leader>j :LspHover<CR>
nmap <Leader>p :LspPeekDefinition<CR>
nmap <Leader>o :LspDefinition<CR>
nmap <Leader>r :LspReferences<CR>

" jump ---------------------------------------
nmap s <Plug>(easymotion-bd-w)w
nmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>s <Plug>(easymotion-sn)

nnoremap * *N<Plug>(quickhl-manual-this)
nnoremap # #N<Plug>(quickhl-manual-this)
nmap " <Plug>(quickhl-manual-this)
nmap <Leader>q <Plug>(quickhl-manual-reset):noh<CR>
if has('win32unix')
  nnoremap * *N
  nnoremap # #N
endif

nmap <Leader>m :marks abcdefghijklmnopqrstuvwxyz<CR>:normal! `
nmap mm :call Marking()<CR>

" window ---------------------------------------
nmap <Leader>nn :set norelativenumber<CR>
nmap <Leader>nr :set relativenumber<CR>

nmap <C-k> <C-w>k
nmap <C-j> <C-w>j
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

nmap <C-p> :bn<CR>
nmap <C-q> :bp<CR>
nmap <Leader>x :call CloseBuf()<CR>

nmap <Leader>t :call TerminalPop()<CR>

nmap <Leader>z :Goyo<CR>:set number<CR>
nmap <Leader>l :Limelight!!<CR>

nmap <Leader>0 :VsnipOpen<CR>

" edit ---------------------------------------
"nmap za <Plug>(sandwich-add)
"nmap zd <Plug>(sandwich-delete)
"nmap zr <Plug>(sandwich-replace)

imap <expr> <Tab> pumvisible() ? '<C-n>' : vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-n>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'

" favorite ---------------------------------------
nmap <Leader><Leader>n :Necronomicon 
nmap <Leader><Leader>w :call RunCat()<CR>
nmap <Leader><Leader>cc :call ChangeColor()<CR>:colorscheme<CR>
nmap <Leader><Leader>ce :call execute('top terminal ++shell eval ' . getline('.'))<CR>
