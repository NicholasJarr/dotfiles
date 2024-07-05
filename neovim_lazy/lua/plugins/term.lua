return {
  {
    "akinsho/toggleterm.nvim",
    version = '*',
    config = function()
      require("toggleterm").setup {
        open_mapping = [[\<leader>]],
        direction = 'float'
      }

      function create_augroup(autocmds, name)
        vim.cmd('augroup ' .. name)
        vim.cmd('autocmd!')
        for _, autocmd in ipairs(autocmds) do
          vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
        end
        vim.cmd('augroup END')
      end

      function rspec_test_line()
        local path = vim.fn.expand('%')
        local lnum = vim.fn.line('.')
        return require('toggleterm').exec(('bin/spring rspec %s:%d'):format(path, lnum), 1)
      end

      function rspec_test_file()
        local path = vim.fn.expand('%')
        return require('toggleterm').exec(('bin/spring rspec %s'):format(path), 1)
      end

      create_augroup({
          { 'BufEnter', '*.rb', [[nnoremap <buffer> \\ <cmd>lua rspec_test_line()<CR>]] },
          { 'BufEnter', '*.rb', [[nnoremap <buffer> \[ <cmd>lua rspec_test_file()<CR>]] },
        }, 'ruby_terminal_commands')
    end
  },
}

