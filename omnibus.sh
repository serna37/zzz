mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start
repos=(
'sheerun/vim-polyglot'
'rafi/awesome-vim-colorschemes'
'vim-airline/vim-airline'
'vim-airline/vim-airline-themes'
'powerline/fonts'
'preservim/nerdtree'
'junegunn/fzf'
'junegunn/fzf.vim'
'prabirshrestha/vim-lsp'
'mattn/vim-lsp-settings'
'yuttie/comfortable-motion.vim'
'easymotion/vim-easymotion'
'simeji/winresizer'
'junegunn/goyo.vim'
'junegunn/limelight.vim'
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
fzf/install --no-key-bindings --completion --no-bash --no-zsh --no-fish
