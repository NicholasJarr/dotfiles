" nvim configuration
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set nocompatible
set autochdir
set ruler
set incsearch
set hlsearch
set autoindent
set smartindent
set cindent
set expandtab
set shiftwidth=2
set softtabstop=2
set ignorecase
set number
set nowrap
set autoread
set guioptions-=L
set guioptions-=r
set guifont=Inconsolata:h16
set belloff=all
set noshowmode
set lazyredraw
set relativenumber
set colorcolumn=80
set updatetime=100
set laststatus=2
let mapleader=" "
let localleader="\\"
syntax on
filetype plugin indent on

set nobackup
set nowritebackup
set noswapfile

set rtp+=/usr/local/opt/fzf
execute pathogen#infect('plugins/{}')
set bg=dark
set termguicolors
colorscheme gruvbox

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:UltiSnipsExpandTrigger="JJ"
let g:UltiSnipsJumpForwardTrigger="JL"
let g:UltiSnipsJumpBackwardTrigger="JH"
inoremap jj <ESC>

noremap <leader>e :tabe $MYVIMRC<cr>
noremap <leader>z :source $MYVIMRC<cr>
noremap <leader>g :Gstatus<CR>
noremap <leader>n :nohlsearch<CR>
noremap <leader>sv :source $MYVIMRC<cr>

noremap <leader>ss :Dispatch! tmux send-keys -t .+ '<C-r>0' Enter<cr>
noremap <leader>sa :Dispatch! tmux send-keys -t .- '<C-r>0' Enter<cr>
noremap <leader>mm :Dispatch! tmux select-pane -t .+<cr>
noremap <leader>mn :Dispatch! tmux select-pane -t .-<cr>
noremap <leader><leader> :Dispatch! tmux send-keys -t 1 '(load "%:p")' Enter<cr>

" True colors in tmux
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
