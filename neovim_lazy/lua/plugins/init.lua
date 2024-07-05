return {
  {
    'echasnovski/mini.nvim', branch = 'stable',
    config = function()
      require('mini.ai').setup()
      require('mini.bracketed').setup()
      require('mini.comment').setup()
      require('mini.cursorword').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.starter').setup()
      require('mini.jump2d').setup({
        view = {
          dim = true
        }
      })

      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      vim.g.minicursorword_disable = true
      vim.api.nvim_set_keymap("n", "<leader><leader>", "<cmd>lua vim.g.minicursorword_disable = not vim.g.minicursorword_disable<cr>", { silent = true, noremap = true })
    end,
  },
}
