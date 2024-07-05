return {
  'neovim/nvim-lspconfig',
  'nvimtools/none-ls.nvim',
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true  })
      vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
      vim.api.nvim_set_keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
    end
  },
  { 'dcampos/nvim-snippy', dependencies = 'honza/vim-snippets' },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'dcampos/cmp-snippy' },
      { 'quangnguyen30192/cmp-nvim-tags' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'onsails/lspkind.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- Icons
      local snippy = require("snippy")
      local lspkind = require('lspkind')
      local cmp = require'cmp'
        cmp.setup({
          snippet = {
            expand = function(args)
              require('snippy').expand_snippet(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif snippy.can_expand_or_advance() then
                snippy.expand_or_advance()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif snippy.can_jump(-1) then
                snippy.previous()
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'snippy' },
          }, {
            { name = 'buffer' },
            { name = 'tags' },
          }),
        formatting = {
          format = lspkind.cmp_format()
        }
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })

      local nvim_lsp = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require("mason-lspconfig").setup_handlers {
          function (server_name)
              require("lspconfig")[server_name].setup {
                capabilities = capabilities,
              }
          end,
          -- Next, you can provide a dedicated handler for specific servers.
          -- For example, a handler override for the `rust_analyzer`:
          -- ["rust_analyzer"] = function ()
          --     require("rust-tools").setup {}
          -- end
      }

      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end
  },
}
