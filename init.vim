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
set guioptions=
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
set guifont=JetBrainsMono\ NF
let mapleader=" "

" plugins
call plug#begin('~/.vim/plugged')
" themes
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim/'

" editing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'godlygeek/tabular'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
Plug 'vimlab/split-term.vim'
Plug 'wellle/context.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'
Plug 'ludovicchabant/vim-gutentags'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" files
Plug 'sheerun/vim-polyglot'

" navigation
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-rooter'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" visual
Plug 'ryanoasis/vim-devicons'
Plug 'kristijanhusak/defx-icons'
Plug 'mhinz/vim-startify'

" airline
Plug 'vim-airline/vim-airline'
Plug 'khatiba/vim-airline-themes'

" c#
Plug 'OmniSharp/omnisharp-vim'

" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
call plug#end()

" colors
colorscheme gruvbox
let g:gruvbox_contrast_dark="soft"

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='transparent'

" lightline
" let g:lightline = {
"       \ 'colorscheme': 'jellybeans',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'mode': 'LightlineMode',
"       \   'filetype': 'MyFiletype',
"       \   'fileformat': 'MyFileformat',
"       \   'gitbranch': 'fugitive#head',
"       \ }
"       \ }
" function! MyFiletype()
"   return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
" endfunction
" function! MyFileformat()
"   return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
" endfunction
" function! LightlineMode()
"   return &filetype ==# 'tagbar' ? 'Tagbar':
"         \ &filetype ==# 'denite' ? 'Denite' :
"         \ &filetype ==# 'defx' ? 'Defx' :
"         \ lightline#mode()
" endfunction

" rooter
let g:rooter_patterns = ['Rakefile', '.git/', '.vscode/', 'package.json']

" denite
call denite#custom#option('_', {
                \ 'start_filter': 1,
                \ 'split': 'floating',
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

call denite#custom#var('file/rec', 'command',
\ ['rg', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

map <leader>pp :DeniteProjectDir file/rec<CR>
map <leader>pc :Denite command<CR>
map <leader>po :Denite outline<CR>
map <leader>pg :Denite grep<CR>
map <leader>pt :Denite tag<CR>

" defx
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> <C-v>
        \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
        \ defx#do_action('open', 'split')
  nnoremap <silent><buffer><expr> <C-t>
        \ defx#do_action('open', 'tabopen')
  nnoremap <silent><buffer><expr> P
        \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
        \ defx#do_action('toggle_columns',
        \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
        \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
        \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
        \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
        \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> -
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
        \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
        \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
endfunction

map - :Defx -columns=icons:indent:filename:type .<CR>
map <leader>fv :Defx -split=vertical -columns=indent:icons:filename:type .<CR>
map <leader>fh :Defx -split=horizontal -columns=indent:icons:filename:type .<CR>
map <leader>ft :Defx -split=tab -columns=indent:icons:filename:type .<CR>
map <leader>fe :Defx -split=vertical -winwidth=25 -direction=topleft -columns=indent:icons:filename:type .<CR>

" easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

map <leader>ss <Plug>(easymotion-overwin-f2)
map <leader>sj <Plug>(easymotion-j)
map <leader>sk <Plug>(easymotion-k)
map <leader>sf <Plug>(easymotion-f)

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

" ultisnips
let g:UltiSnipsExpandTrigger="JJ"
let g:UltiSnipsJumpForwardTrigger="JL"
let g:UltiSnipsJumpBackwardTrigger="JH"

" fugitive
nnoremap <leader>gg :Gstatus<CR>

" tagbar
nnoremap <leader>tt :Tagbar<CR>

" omnisharp
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 3

" misc
" Zoom / Restore window.
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction

command! ZoomToggle call s:ZoomToggle()

inoremap jj <ESC>
nnoremap <leader>ee :tabe $MYVIMRC<CR>
nnoremap <leader>es :source $MYVIMRC<CR>
nnoremap <leader>' :10Term<CR>
nnoremap <silent> <leader>wf :ZoomToggle<CR>

au BufRead,BufNewFile *.cls set syntax=java 
au BufRead,BufNewFile *.cmp set syntax=xml 
au BufRead,BufNewFile *.evt set syntax=xml 

" TODO: Check later
" hi ActiveWindow ctermbg=None ctermfg=None guibg=None
" hi InactiveWindow ctermbg=darkgray ctermfg=gray guibg=#282c34
" set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

" True colors in tmux
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
