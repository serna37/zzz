" base ---------------------------------------
let g:mapleader = "\<Space>"

" looks ---------------------------------------
nmap <Leader>cc :call ChangeColor()<CR>:colorscheme<CR>

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

" search/mark/jump ---------------------------------------
nmap s <Plug>(easymotion-overwin-f2)
nmap <Leader>s <Plug>(easymotion-sn)

nmap <Leader>* <Plug>(quickhl-manual-this)
nmap <Leader><Leader>* <Plug>(quickhl-manual-reset)

nmap <Leader>m :marks abcdefghijklmnopqrstuvwxyz<CR>:normal! `
nmap mm :call Marking()<CR>

nmap <Leader>q :noh<CR>

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

" completion ---------------------------------------
imap <expr> <Tab> pumvisible() ? '<C-n>' : vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-n>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'

" favorite ---------------------------------------
nmap <Leader><Leader>n :Necronomicon 
nmap <Leader><Leader>w :call RunCat()<CR>
nmap <Leader><Leader>ce :call execute('top terminal ++shell eval ' . getline('.'))<CR>
