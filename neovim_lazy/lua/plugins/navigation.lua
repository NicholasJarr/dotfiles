return {
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
      vim.api.nvim_set_keymap("n", "-", "<cmd>Oil<cr>", { silent = true, noremap = true })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ["<C-w>"] = actions.send_selected_to_qflist,
              ["<C-q>"] = actions.send_to_qflist,
              ["<C-Space>"] = actions.to_fuzzy_refine,
            },
            n = {
              ["<C-w>"] = actions.send_selected_to_qflist,
              ["<C-q>"] = actions.send_to_qflist,
            }
          },
        },
      }

      vim.api.nvim_set_keymap('n', '<c-p>', ':Telescope find_files<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>pg', ':Telescope live_grep<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>pb', ':Telescope buffers<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>pt', ':Telescope tags<cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>pp', ':Telescope current_buffer_tags<cr>', { noremap = true })
    end
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end
  },
}
