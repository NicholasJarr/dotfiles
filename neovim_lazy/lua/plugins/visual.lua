return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local function gutentags_status()
        if vim.api.nvim_call_function("gutentags#statusline") then
          return ' '
        end
      end

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = '|',
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {{'mode', separator = { left = '' }, right_padding = 2 }},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {gutentags_status, 'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {{'location', separator = { right = '' }, right_padding = 2}}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },
  'lukas-reineke/indent-blankline.nvim',
  {
    'sheerun/vim-polyglot',
    config = function()
      vim.g.markdown_folding = 1
    end
  },
  'kyazdani42/nvim-web-devicons',
  {
    'm4xshen/smartcolumn.nvim',
    config = function()
      require("smartcolumn").setup {
        disabled_filetypes = { "help", "text", "markdown", "startify", "fugitive", "starter" }
      }
    end
  },
  {
    'dstein64/nvim-scrollview',
    config = function()
      require("scrollview").setup()
      vim.api.nvim_command('hi link ScrollView StatusLine')
    end
  },
  {
    'alvarosevilla95/luatab.nvim',
    config = function()
      require('luatab').setup{}
    end
  },
}
