mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start
repos=(
'sheerun/vim-polyglot'
'rafi/awesome-vim-colorschemes'
'vim-airline/vim-airline'
'vim-airline/vim-airline-themes'
'powerline/fonts'
'airblade/vim-gitgutter'
'tpope/vim-fugitive'
'preservim/nerdtree'
'Xuyuanp/nerdtree-git-plugin'
'junegunn/fzf'
'junegunn/fzf.vim'
'obcat/vim-hitspop'
't9md/vim-quickhl'
'prabirshrestha/vim-lsp'
'mattn/vim-lsp-settings'
'yuttie/comfortable-motion.vim'
'easymotion/vim-easymotion'
'kshenoy/vim-signature'
'simeji/winresizer'
'junegunn/goyo.vim'
'junegunn/limelight.vim'
'machakann/vim-sandwich'
'prabirshrestha/asyncomplete.vim'
'prabirshrestha/asyncomplete-lsp.vim'
'prabirshrestha/asyncomplete-buffer.vim'
'koturn/asyncomplete-dictionary.vim'
'akaimo/asyncomplete-around.vim'
'hrsh7th/vim-vsnip'
'hrsh7th/vim-vsnip-integ'
'rafamadriz/friendly-snippets'
)
for v in ${repos[@]}; do
  git clone --depth 1 "https://github.com/${v}"
done
sh fonts/install.sh
fzf/install --no-key-bindings --no-completion --update-rc
