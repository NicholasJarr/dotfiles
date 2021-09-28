vim.o.hidden = true
vim.o.autochdir = false
vim.o.hlsearch = false
vim.o.cindent = true
vim.o.shiftwidth=2
vim.o.ignorecase = true
vim.o.wrap = false
vim.o.belloff = 'all'
vim.o.showmode = false
vim.o.lazyredraw = true
vim.o.updatetime = 100
vim.o.laststatus = 2
vim.o.bg = 'light'
vim.o.termguicolors = true
vim.o.shortmess = 'filnxtToOFc'    -- Shut off completion messages
vim.o.guifont = 'Iosevka NF:h11'
vim.o.mouse = 'a'
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.colorcolumn = '80'
vim.bo.softtabstop = 2
vim.bo.smartindent = true
vim.bo.expandtab = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if vim.g.neovide then
 vim.o.termguicolors = false 
 vim.o.guifont = 'Iosevka NF:h13'
end

-- better vim temp file handling
vim.o.backup = true
vim.o.backupdir = vim.env.HOME .. '/.vim/files/backup/'
vim.o.backupext = '-vimbackup'
vim.o.backupskip = ''
vim.o.directory = vim.env.HOME .. '/.vim/files/swap/'
vim.o.updatecount = 100
vim.o.undofile = true
vim.o.undodir = vim.env.HOME .. '/.vim/files/undo/'
vim.api.nvim_command("set viminfo='100,n$HOME/.vim/files/info/viminfo")

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

-- Packages

local use = require('packer').use
require('packer').startup(function()
  -- package manager
  use 'wbthomason/packer.nvim'

  -- themes
  use 'morhetz/gruvbox'
  use 'joshdick/onedark.vim'
  use 'mcchrish/zenbones.nvim'

  -- editing
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'machakann/vim-sandwich'
  use 'godlygeek/tabular'
  use 'editorconfig/editorconfig-vim'

  -- navigation
  use 'tpope/vim-vinegar'
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use "ahmedkhalf/project.nvim"

  -- git
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- visual
  use 'kyazdani42/nvim-web-devicons' 
  use 'mhinz/vim-startify'
  use 'itchyny/lightline.vim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'sheerun/vim-polyglot'
  -- use 'alvarosevilla95/luatab.nvim'
  -- use after configuring galaxyline

  -- tags
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management

  -- completion

  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use { 'ms-jpq/coq_nvim', branch = 'coq'} -- main one
  use { 'ms-jpq/coq.artifacts', branch= 'artifacts'} -- 9000+ Snippets
end)

-- gruvbox
vim.g.gruvbox_italic = 1
vim.cmd [[colorscheme zenbones]]

-- onedark
-- vim.g.onedark_terminal_italics = 2
-- vim.cmd [[colorscheme onedark]]

-- lightline
vim.g.lightline = {
  -- separator = { left = '', right = '' },
  -- subseparator = { left = '', right = '' },
  colorscheme = 'zenbones',
  active = { 
    left = { { 'mode', 'paste' },
              { 'gitbranch', 'readonly', 'filename', 'modified' } },
    right = { { 'lineinfo' },
             { 'percent' },
             { 'fileformat', 'fileencoding', 'filetype' } },
  },
  component_function = {
    filetype = 'MyFiletype',
    fileformat = 'MyFileformat',
    gitbranch = 'fugitive#head',
  },
  enable = {
    statusline = 1,
    tabline = 1
  }
}

function MyFiletype()
  return vim.api.nvim_eval("winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''")
end

function MyFileformat()
  return vim.api.nvim_eval("winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''")
end

-- tabline
-- vim.o.tabline = '%!v:lua.require\'luatab\'.tabline()'

-- rooter
-- vim.g.rooter_patterns = { '.git' }

-- startify
vim.api.nvim_command('au FileType startify IndentBlanklineDisable')

-- indent_blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- fugitive
vim.api.nvim_set_keymap('n', '<leader>gg', ':Git<cr>', { noremap = true })

-- telescope
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    disable_devicons = true,
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-w>"] = actions.send_selected_to_qflist,
        ["<C-q>"] = actions.send_to_qflist,
      },
      n = {
        ["<C-w>"] = actions.send_selected_to_qflist,
        ["<C-q>"] = actions.send_to_qflist,
      }
    },
  },
}
require('telescope').load_extension('projects')

vim.api.nvim_set_keymap('n', '<c-p>', ':Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pp', ':Telescope projects<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>pg', ':Telescope live_grep<cr>', { noremap = true })

-- project_nvim
require("project_nvim").setup{}

-- coq_nvim
vim.g.coq_settings = {
  auto_start = 'shut-up',
}

-- coq and lspconfig
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local coq = require 'coq'

local servers = { 'tsserver', 'pyright', 'clangd', 'omnisharp' }
for _, lsp in ipairs(servers) do
  if lsp == 'omnisharp' then
    local pid = vim.fn.getpid()
    local omnisharp_bin = "C:/Users/NicholasJarretta/scoop/apps/omnisharp/current/OmniSharp.exe"

    nvim_lsp.omnisharp.setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
      cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) }
    }))
  else
    nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }))
  end
end

require'lspsaga'.init_lsp_saga()

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Keymaps
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('n', 'vv', '<c-w>v', { noremap = true })
vim.api.nvim_set_keymap('n', 'vh', '<c-w>s', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ee', ':tabe $MYVIMRC<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>es', ':source $MYVIMRC<cr>', { noremap = true })
vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', { noremap = true })
vim.api.nvim_set_keymap('n', '[q', ':cp<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ']q', ':cn<cr>', { noremap = true })
