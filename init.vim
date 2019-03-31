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
set bg=dark
set termguicolors
let mapleader=" "
let localleader="\\"

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'honza/vim-snippets'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete'
Plug 'Rip-Rip/clang_complete'
Plug 'tpope/vim-vinegar'
call plug#end()

set nobackup
set nowritebackup
set noswapfile

colorscheme gruvbox

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:UltiSnipsExpandTrigger="JJ"
let g:UltiSnipsJumpForwardTrigger="JL"
let g:UltiSnipsJumpBackwardTrigger="JH"
let g:airline_extensions = ['branch', 'tabline']
let g:airline_theme = 'gruvbox'
let g:deoplete#enable_at_startup = 1
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'

inoremap jj <ESC>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
noremap <leader>e :tabe $MYVIMRC<cr>
noremap <leader>z :source $MYVIMRC<cr>
noremap <leader>g :Gstatus<CR>
noremap <leader>n :nohlsearch<CR>
noremap <leader>r :ClearAllCtrlPCaches<cr>
noremap <leader>v :vs .<cr>
noremap <leader>b :split .<cr>

noremap <leader>fg :!npx eslint --fix %<cr>
noremap <leader>ss yap:Dispatch psql postgres nicho -c "<C-r>0"<cr>
noremap <leader>mm :Dispatch tmux select-pane -t .+<cr>
noremap <leader>mn :Dispatch tmux select-pane -t .-<cr>
noremap <silent> <leader><leader> :Dispatch! tmux send-keys -t .+ "npm test" Enter<cr>

au BufRead,BufNewFile *.cls set syntax=java 
au BufRead,BufNewFile *.cmp set syntax=xml 
au BufRead,BufNewFile *.evt set syntax=xml 

" True colors in tmux
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
