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
let mapleader=" "
let localleader="\\"
syntax on
filetype plugin indent on

set nobackup
set nowritebackup
set noswapfile

set rtp+=/usr/local/opt/fzf
execute pathogen#infect()
set termguicolors
set bg=dark
colorscheme gruvbox

" autocmd bufwritepost *.js silent !npx standard --fix %

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:ale_linters = {
\   'javascript': ['standard'],
\}
" let g:lightline = {
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"     \   'gitbranch': 'fugitive#head'
"       \ },
"       \ }
" let g:lightline.colorscheme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:UltiSnipsExpandTrigger="JJ"
let g:UltiSnipsJumpForwardTrigger="Jn"
let g:UltiSnipsJumpBackwardTrigger="Jp"
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let test#strategy = "dispatch"
inoremap jj <ESC>

noremap <leader>e :tabe $MYVIMRC<cr>
noremap <leader>z :source $MYVIMRC<cr>
noremap <leader>g :Gstatus<CR>
noremap <leader>n :nohlsearch<CR>
noremap <leader>b :Grepper -tool rg -prompt<CR>
noremap <leader>r 20<C-W>+
" imap <CR> <ESC>:TestNearest<CR><CR>
map <leader>t :tab split<CR>

" True colors in tmux
"if &term =~# '^screen'
    " let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    " let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"endif

" Terminal mappings
tnoremap <Esc> <C-\><C-N>
