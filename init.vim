" nvim configuration
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set encoding=UTF-8
set nocompatible
set autochdir
set ruler
set incsearch
set nohlsearch
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
set completeopt+=longest,menuone,noselect
set shortmess+=c    " Shut off completion messages

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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'honza/vim-snippets'
Plug 'w0rp/ale'
Plug 'tpope/vim-vinegar'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-rooter'
Plug 'lifepillar/vim-mucomplete'
Plug 'editorconfig/editorconfig-vim'
Plug 'davidhalter/jedi-vim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'majutsushi/tagbar'
Plug 'OmniSharp/omnisharp-vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
call plug#end()

colorscheme gruvbox

let g:UltiSnipsExpandTrigger="JJ"
let g:UltiSnipsJumpForwardTrigger="JL"
let g:UltiSnipsJumpBackwardTrigger="JH"
let g:airline_extensions = ['branch', 'tabline']
let g:airline_theme = 'gruvbox'
let g:rooter_patterns = ['.git/']
let g:OmniSharp_highlight_types = 1
let g:JavaComplete_EnableDefaultMappings = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:mucomplete#completion_delay = 1
let g:mucomplete#enable_auto_at_startup = 1

" ale
let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\ 'javascript': ['eslint']
\}

" denite
call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#alias('source', 'file_rec', 'file/rec')
call denite#custom#var('file_rec', 'command',
      \ ['git', 'ls-tree', '--full-tree', '-r', '--name-only', 'HEAD'])
call denite#custom#var('file/rec/git', 'command',
      \ ['git', 'ls-tree', '--full-tree', '-r', '--name-only', 'HEAD'])
call denite#custom#map(
        \ 'insert',
        \ '<C-t>',
        \ '<denite:do_action:tabopen>',
        \ 'noremap'
        \)
call denite#custom#map(
        \ 'insert',
        \ '<C-v>',
        \ '<denite:do_action:vsplit>',
        \ 'noremap'
        \)
call denite#custom#map(
        \ 'insert',
        \ '<C-h>',
        \ '<denite:do_action:split>',
        \ 'noremap'
        \)
call denite#custom#map(
        \ 'insert',
        \ '<C-j>',
        \ '<denite:move_to_next_line>',
        \ 'noremap'
        \)
call denite#custom#map(
        \ 'insert',
        \ '<C-k>',
        \ '<denite:move_to_previous_line>',
        \ 'noremap'
        \)
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" easymotion
map <leader>s <Plug>(easymotion-overwin-f2)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

inoremap jj <ESC>

noremap <C-p><C-p> :Denite -split=floating file_rec<cr>
noremap <C-p><C-g> :Denite -split=floating grep<cr>
noremap <C-p><C-o> :Denite -split=floating outline<cr>
noremap <leader>t :TagbarToggle<cr>
noremap <leader>e :tabe $MYVIMRC<cr>
noremap <leader>z :source $MYVIMRC<cr>
noremap <leader>g :Gstatus<CR>
noremap <leader>n :NERDTreeToggle<CR>

au BufRead,BufNewFile *.cls set syntax=java 
au BufRead,BufNewFile *.cmp set syntax=xml 
au BufRead,BufNewFile *.evt set syntax=xml 

autocmd FileType java setlocal omnifunc=javacomplete#Complete

" True colors in tmux
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
