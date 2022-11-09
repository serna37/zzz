mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start
repos=(
'mhinz/vim-startify'
#'vim-airline/vim-airline'
#'vim-airline/vim-airline-themes'
'rafi/awesome-vim-colorschemes'
'sheerun/vim-polyglot'
'uiiaoo/java-syntax.vim'
#'powerline/fonts'
#'ryanoasis/vim-devicons'
#'ryanoasis/nerd-fonts'
'preservim/nerdtree'
'Xuyuanp/nerdtree-git-plugin'
'junegunn/fzf'
'junegunn/fzf.vim'
'ctrlpvim/ctrlp.vim'
'mattn/ctrlp-matchfuzzy'
'tpope/vim-fugitive'
'airblade/vim-gitgutter'
'prabirshrestha/vim-lsp'
'mattn/vim-lsp-settings'
'machakann/vim-sandwich'
'prabirshrestha/asyncomplete.vim'
'prabirshrestha/asyncomplete-lsp.vim'
'prabirshrestha/asyncomplete-buffer.vim'
'koturn/asyncomplete-dictionary.vim'
'akaimo/asyncomplete-around.vim'
'hrsh7th/vim-vsnip'
'hrsh7th/vim-vsnip-integ'
'rafamadriz/friendly-snippets'
'easymotion/vim-easymotion'
'yuttie/comfortable-motion.vim'
'simeji/winresizer'
'kshenoy/vim-signature'
'obcat/vim-hitspop'
't9md/vim-quickhl'
'junegunn/goyo.vim'
'junegunn/limelight.vim'
)
for v in ${repos[@]}; do
  git clone --depth 1 "https://github.com/${v}"
done
#sh fonts/install.sh
#sh nerd-fonts/install.sh
fzf/install --no-key-bindings --no-completion --update-rc
