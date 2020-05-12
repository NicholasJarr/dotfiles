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
Plug 'editorconfig/editorconfig-vim'
Plug 'davidhalter/jedi-vim'
Plug 'majutsushi/tagbar'
Plug 'OmniSharp/omnisharp-vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'adamclerk/vim-razor'
Plug 'janko/vim-test'
Plug 'Lokaltog/vim-monotone'
Plug 'ewilazarus/preto'
Plug 'xavierd/clang_complete'
Plug 'wellle/targets.vim'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-sources', {'rtp': './packages/coc-tag', 'do': 'yarn install --frozen-lockfile'}
call plug#end()

colorscheme gruvbox

let g:UltiSnipsExpandTrigger="JJ"
let g:UltiSnipsJumpForwardTrigger="JL"
let g:UltiSnipsJumpBackwardTrigger="JH"
let g:airline_extensions = ['branch', 'tabline']
let g:airline_theme = 'gruvbox'
let g:rooter_patterns = ['package.json', '.git/']
let g:OmniSharp_highlight_types = 1
let g:OmniSharp_server_stdio = 1
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:jedi#auto_initialization = 0
let g:jedi#auto_vim_configuration = 0
let g:ale_python_pylint_executable='pipenv'
let g:rustfmt_autosave = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" ale
let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\ 'javascript': ['eslint']
\}

" denite
call denite#custom#option('_', {
                \ 'start_filter': 1,
                \ 'split': 'floating',
                \ })
call denite#custom#var('file/rec', 'command',
      \ ['rg', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

let s:menus = {}
let s:menus.tests = {
      \ 'description': 'Tests commands'
      \ }
let s:menus.tests.command_candidates = [
      \ ['Suite', 'TestSuite'],
      \ ['File', 'TestFile'],
      \ ['Last', 'TestLast'],
      \ ['Visit', 'TestVisit'],
      \ ['Nearest', 'TestNearest'],
      \ ]
let s:menus.csharp = {
      \ 'description': 'C# commands'
      \ }
let s:menus.csharp.command_candidates = [
      \ ['Format', 'OmniSharpCodeFormat'],
      \ ]
let s:menus.git = {
      \ 'description': 'Git commands'
      \ }
let s:menus.git.command_candidates = [
      \ ['Status', 'Gstatus'],
      \ ]
let s:menus.commands = {
      \ 'description': 'My commands for editing'
      \ }
let s:menus.commands.command_candidates = [
      \ ['Files', 'Denite file/rec'],
      \ ['Files from git', 'Denite file/rec/git'],
      \ ['Grep', 'Denite grep'],
      \ ['Outline', 'Denite outline'],
      \ ]
call denite#custom#var('menu', 'menus', s:menus)

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> v
        \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> V
        \ denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> t
        \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
        \ denite#do_map('toggle_select').'j'
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer><expr> <Esc> denite#do_map('quit')
  imap <silent><buffer><expr> <CR> denite#do_map('do_action')
  imap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  imap <silent><buffer><expr> <C-h> denite#do_map('do_action', 'split')
  imap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
  imap <silent><buffer><expr> <C-d> denite#do_map('do_action', 'delete')
  imap <silent><buffer><expr> <C-p> denite#do_map('do_action', 'preview')
  imap <silent><buffer><expr> <C-space> denite#do_map('denite_filter_quit')
endfunction


" easymotion
map <leader>s <Plug>(easymotion-overwin-f2)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)

" coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader><leader> :CocFix<CR>

" Goyo and Limelight
noremap <C-g><C-g> :Goyo<cr>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" vim-test
let test#strategy = 'dispatch'

" clang_complete
let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
if isdirectory(s:clang_library_path)
    let g:clang_library_path=s:clang_library_path
endif

inoremap jj <ESC>
noremap <C-p> :Denite file/rec<cr>
noremap <leader>o :Denite outline<cr>
noremap <leader>v :vs .<cr>
noremap <leader>i :Denite menu<cr>
noremap <leader>t :TagbarToggle<cr>
noremap <leader>e :tabe $MYVIMRC<cr>
noremap <leader>z :source $MYVIMRC<cr>
noremap <leader>g :Gstatus<CR>
noremap <leader>n :NERDTreeToggle<CR>

au BufRead,BufNewFile *.cls set syntax=java 
au BufRead,BufNewFile *.cmp set syntax=xml 
au BufRead,BufNewFile *.evt set syntax=xml 

" True colors in tmux
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
