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
set completeopt+=longest,menuone,noselect
set shortmess+=c    " Shut off completion messages
set belloff+=ctrlg  " If Vim beeps during completion
set guifont=ProggyCleanTTSZ\ Nerd\ Font\ Mono:h18
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
Plug 'ludovicchabant/vim-gutentags'
Plug 'Konfekt/FastFold'
Plug 'easymotion/vim-easymotion'

" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" test
Plug 'janko/vim-test'

" git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'sodapopcan/vim-twiggy'
Plug 'airblade/vim-gitgutter'

" files
Plug 'sheerun/vim-polyglot'

" navigation
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/vista.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-mapping-project-top.vim'
Plug 'lambdalisue/fern-renderer-devicons.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'voldikss/vim-floaterm'
Plug 'airblade/vim-rooter'

" command
Plug 'tpope/vim-dispatch'

" visual
Plug 'ryanoasis/vim-devicons'
Plug 'kristijanhusak/defx-icons'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" lightline
Plug 'itchyny/lightline.vim'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" hex
Plug 'fidian/hexmode'
call plug#end()

colorscheme gruvbox

" files
nnoremap - :Fern .<CR>
nnoremap <leader><leader>d :Fern . -drawer<CR>
nnoremap <leader><leader>v :vs .<CR>:Fern .<CR>
nnoremap <leader><leader>h :sp .<CR>:Fern .<CR>
nnoremap <leader><leader>t :tabe .<CR>:Fern .<CR>

augroup Fern
  autocmd!

  autocmd FileType fern nnoremap ~ :Fern ~<CR>
augroup end

" gutentags
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

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

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nmap s <Plug>(easymotion-overwin-f2)

" floaterm
let g:floaterm_keymap_new    = '<leader>fk'
let g:floaterm_keymap_prev   = '<leader>fh'
let g:floaterm_keymap_next   = '<leader>fl'
let g:floaterm_keymap_toggle = '<leader>ff'

"ultisnips
let g:UltiSnipsExpandTrigger="JJ"
let g:UltiSnipsJumpForwardTrigger="JL"
let g:UltiSnipsJumpBackwardTrigger="JH"

" fugitive
nnoremap <leader>gg :Gstatus<CR>
nnoremap <leader>gb :Twiggy 
nnoremap <leader>gt :Twiggy<CR>
nnoremap <leader>gv :GV<CR>

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

" fern
let g:fern#renderer = "devicons"

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
      \            [ 'gutentags', 'fileformat', 'fileencoding', 'filetype' ] ],
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

augroup MyGutentagsStatusLineRefresher
  autocmd!
  autocmd User GutentagsUpdating call lightline#update()
  autocmd User GutentagsUpdated call lightline#update()
augroup END

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
map <c-p><c-l> :Denite floaterm floaterm:new -auto-action=preview<CR>
map <c-p><c-n> :Denite -path=~/OneDrive\ -\ TeslaTech/Notes file/rec file:new<CR>

" misc
function! WriterMode()
  if exists("g:writer_mode") && g:writer_mode == v:true
    set bg=dark
    colorscheme gruvbox

    let g:writer_mode = v:false
  else
    set bg=light
    colorscheme pencil

    let g:writer_mode = v:true
  endif

  Goyo
  redraw
endfunction

function! s:goyo_enter()
    Limelight
    IndentLinesDisable
endfunction
function! s:goyo_leave()
    Limelight!
    IndentLinesEnable
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeaver nested call <SID>goyo_leave()

inoremap jj <ESC>
nnoremap <leader>ww :call WriterMode()<CR>
nnoremap <leader>wg :Goyo<CR>
nnoremap <leader>ee :tabe $MYVIMRC<CR>
nnoremap <leader>es :source $MYVIMRC<CR>

" True colors in tmux
if &term =~# '^screen'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
