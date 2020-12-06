" nvim configuration
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

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
set guifont=Hack\ NF:h14
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
Plug 'reedes/vim-colors-pencil'
Plug 'chriskempson/base16-vim/'

" editing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-sandwich'
Plug 'wellle/targets.vim'
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'Konfekt/FastFold'
Plug 'easymotion/vim-easymotion'

" completion
Plug 'lifepillar/vim-mucomplete'
Plug 'dense-analysis/ale'
Plug 'OmniSharp/omnisharp-vim'

" terminal
Plug 'rhysd/reply.vim'

" test
Plug 'janko/vim-test'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" files
Plug 'sheerun/vim-polyglot'

" navigation
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/vista.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'

" command
Plug 'tpope/vim-dispatch'

" visual
Plug 'ryanoasis/vim-devicons'
Plug 'kristijanhusak/defx-icons'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'

" lightline
Plug 'itchyny/lightline.vim'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" hex
Plug 'fidian/hexmode'
call plug#end()

colorscheme gruvbox

" mucomplete
let g:mucomplete#enable_auto_at_startup = 0
let g:mucomplete#completion_delay = 0
let g:mucomplete#can_complete = {}
let g:mucomplete#can_complete.default = { 'omni': { t -> 1 } }
let g:mucomplete#chains = {
    \ 'default' : ['path', 'ulti', 'omni', 'keyn', 'dict', 'uspl'],
    \ 'vim'     : ['path', 'ulti', 'cmd', 'keyn']
    \ }

" ale
let g:ale_set_balloons = 1
let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\ 'rust': ['rls']
\}
let g:ale_completion_symbols = {
\ 'text': '',
\ 'method': '',
\ 'function': '',
\ 'constructor': '',
\ 'field': '',
\ 'variable': '',
\ 'class': '',
\ 'interface': '',
\ 'module': '',
\ 'property': '',
\ 'unit': 'unit',
\ 'value': 'val',
\ 'enum': '',
\ 'keyword': 'keyword',
\ 'snippet': '',
\ 'color': 'color',
\ 'file': '',
\ 'reference': 'ref',
\ 'folder': '',
\ 'enum member': '',
\ 'constant': '',
\ 'struct': '',
\ 'event': 'event',
\ 'operator': '',
\ 'type_parameter': 'type param',
\ '<default>': 'v'
\ }
set omnifunc=ale#completion#OmniFunc

" omnisharp
au FileType cs setlocal omnifunc=OmniSharp#Complete

" reply.vim

let s:repl_cs = reply#repl#base('dotnet', {
    \   'prompt_start' : '^>',
    \   'prompt_continue' : '^*',
    \ })

function! s:repl_cs.executable() abort
    return self.get_var('executable', 'dotnet')
endfunction


function! s:repl_cs.get_command() abort
    return [self.executable(), 'script'] + self.get_var('command_options', [])
endfunction

function! s:define_repl_cs() abort
    return deepcopy(s:repl_cs)
endfunction

let g:reply_repls = {
\   'cs': [function('s:define_repl_cs')]
\ }

nnoremap <leader>rr :Repl<CR>
nnoremap <leader>ra :ReplAuto<CR>
nnoremap <leader>rc :ReplRecv<CR>
nnoremap <leader>rs :ReplSend<CR>
nnoremap <leader>rt :ReplStop<CR>

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nmap ss <Plug>(easymotion-overwin-f2)

" ultisnips
let g:UltiSnipsExpandTrigger="JJ"
let g:UltiSnipsJumpForwardTrigger="JL"
let g:UltiSnipsJumpBackwardTrigger="JH"

" fugitive
nnoremap <leader>gg :Gstatus<CR>

" vista
au FileType vista IndentLinesDisable
nnoremap <leader>tt :Vista<CR>

" test
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>

" indent line
let g:indentLine_setColors = 1
let g:indentLine_fileTypeExclude = ['fzf']

" term
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <Esc>
tnoremap <C-v><Esc> <Esc>

" fast fold
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

" startify
au FileType startify IndentLinesDisable

" markdown
let g:vim_markdown_conceal=0

nnoremap <leader>mm :MarkdownPreview<CR>
nnoremap <leader>mn :MarkdownPreviewStop<CR>

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
      \   'gutentags': 'gutentags#statusline',
      \ }
      \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
function! LightlineMode()
  return &filetype ==# 'vista' ? 'Vista':
        \ &filetype ==# 'denite' ? 'Denite' :
        \ &filetype ==# 'defx' ? 'Defx' :
        \ lightline#mode()
endfunction

" denite
call denite#custom#option('_', {
      \ 'start_filter': 1,
      \ 'split': 'floating',
      \ 'vertical_preview': v:true,
      \ 'floating_preview': v:true,
      \ })
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
        \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
        \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
        \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> h
        \ denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> v
        \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> t
        \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> q
        \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
        \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
        \ denite#do_map('toggle_select').'j'
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  inoremap <silent><buffer><expr> <C-c> 
        \ denite#do_map('quit')
endfunction

call denite#custom#var('file/rec', 'command',
      \ ['rg', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

map <c-p><c-p> :DeniteProjectDir file/rec file:new<CR>
map <c-p>: :Denite command<CR>
map <c-p><c-o> :Denite outline<CR>
map <c-p><c-g> :Denite grep<CR>
map <c-p><c-t> :Denite tag<CR>
map <c-p><c-n> :Denite -path=~/notes file/rec file:new<CR>

" misc
inoremap jj <ESC>
nnoremap <leader>ee :tabe $MYVIMRC<CR>
nnoremap <leader>es :source $MYVIMRC<CR>

" True colors in tmux
if &term =~# '^screen'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
