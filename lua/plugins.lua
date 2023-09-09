-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
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

local use = require('packer').use
require('packer').startup(function()
  -- package manager
  use 'wbthomason/packer.nvim'

  -- themes
  use 'RRethy/nvim-base16'
  use 'NLKNguyen/papercolor-theme'
  use { "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" }

  -- editing
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-commentary'
  use 'machakann/vim-sandwich'
  use 'godlygeek/tabular'
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-unimpaired'
  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup()
      vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require'hop'.hint_char2({ direction = nil, multi_windows = true })<cr>", { noremap = true })
    end
  }
  use 'mattn/emmet-vim'

  -- navigation
  use 'tpope/vim-vinegar'
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } }
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end
  }

  -- git
  use 'tpope/vim-fugitive'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use "sindrets/diffview.nvim"

  -- visual
  use 'mhinz/vim-startify'
  use 'nvim-lualine/lualine.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'sheerun/vim-polyglot'
  use 'kyazdani42/nvim-web-devicons'
  use 'm4xshen/smartcolumn.nvim'
  use 'dstein64/nvim-scrollview'
  use 'alvarosevilla95/luatab.nvim'

  -- tags
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  use 'preservim/tagbar'

  -- completion
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use { 'dcampos/nvim-snippy', requires = 'honza/vim-snippets' }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'dcampos/cmp-snippy' },
      { 'quangnguyen30192/cmp-nvim-tags' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    }
  }

  -- term
  use { "akinsho/toggleterm.nvim", tag = '*' }

  -- dependencies
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
