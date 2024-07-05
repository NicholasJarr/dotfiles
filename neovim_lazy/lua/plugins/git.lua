return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>gg', ':Git<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<cr>', { noremap = true })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
      vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitGutterAdd' })
      vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitGutterChange' })
      vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitGutterChange' })
      vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitGutterDelete' })
      vim.api.nvim_set_hl(0, 'GitSignsTopDelete', { link = 'GitGutterDelete' })
      vim.api.nvim_set_hl(0, 'GitSignsChangeDelete', { link = 'GitGutterDelete' })
    end
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>gd', ':DiffviewFileHistory %<cr>', { noremap = true })
    end
  }
}
