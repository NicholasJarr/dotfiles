" nvim configuration
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set hidden
set noautochdir
set nohlsearch
set smartindent
set cindent
set expandtab
set shiftwidth=2
set softtabstop=2
set ignorecase
set number
set nowrap
set guioptions=
set belloff=all
set noshowmode
set lazyredraw
set relativenumber
set updatetime=100
set laststatus=2
set bg=dark
set termguicolors
set completeopt=menu,menuone,noselect,noinsert
set shortmess+=c    " Shut off completion messages
set belloff+=ctrlg  " If Vim beeps during completion
set guifont=Iosevka\ Fixed:h11
set colorcolumn=80
let mapleader=" "

" better vim temp file handling
set backup
set backupdir=$HOME/.vim/files/backup/
set backupext=-vimbackup
set backupskip=
set directory=$HOME/.vim/files/swap/
set updatecount=100
set undofile
set undodir=$HOME/.vim/files/undo/
set viminfo='100,n$HOME/.vim/files/info/viminfo

call plug#begin('~/.vim/plugged')
" themes
Plug 'morhetz/gruvbox'

" editing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'

" navigation
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" files
Plug 'sheerun/vim-polyglot'

" visual
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'

" command
Plug 'tpope/vim-dispatch'

" test
Plug 'vim-test/vim-test'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
call plug#end()

" gruvbox
let g:gruvbox_italic=1
colorscheme gruvbox

" coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>ca  <Plug>(coc-codeaction)

" ultisnips
let g:UltiSnipsExpandTrigger="JJ"
let g:UltiSnipsJumpForwardTrigger="JK"
let g:UltiSnipsJumpBackwardTrigger="JL"

" fzf
noremap <c-p><c-p> :Files<CR>
noremap <c-p><c-g> :Rg<CR>

" emmet
let g:user_emmet_leader_key = '\'
let g:user_emmet_expandabbr_key = '\\'

let g:user_emmet_install_global = 0
autocmd FileType html,php,scss,sass,css,eruby,javascript,javascriptreact,typescript,typescriptreact EmmetInstall


" lightline
let g:lightline = {
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'mode': 'LightlineMode',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'gitbranch': 'fugitive#head',
      \ }
      \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineMode()
  return expand('%:t') ==# 'ControlP' ? 'CtrlP' :
        \ lightline#mode()
endfunction

" fugitive
nnoremap <leader>gg :Gstatus<CR>

" indent line
let g:indentLine_setColors = 1

" startify
au FileType startify IndentLinesDisable

" vimux
nnoremap <leader>vv :VimuxRunLastCommand<CR>
nnoremap <leader>vp :VimuxPromptCommand<CR>
nnoremap <leader>vi :VimuxInspectRunner<CR>
nnoremap <leader>vz :VimuxZoomRunner<CR>

" rust
let g:rustfmt_autosave = 1

" test
let test#strategy = 'dispatch'
noremap <leader>tt :TestNearest<CR>
noremap <leader>tf :TestFile<CR>
noremap <leader>ts :TestSuite<CR>
noremap <leader>tl :TestLast<CR>
noremap <leader>tv :TestVisit<CR>

" misc
inoremap jj <ESC>
nnoremap ss /
nnoremap <silent> vv <c-w>v
nnoremap <silent> vh <c-w>s
nnoremap <leader>ee :tabe $MYVIMRC<CR>
nnoremap <leader>es :source $MYVIMRC<CR>
