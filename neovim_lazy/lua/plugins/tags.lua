return {
  {
    'ludovicchabant/vim-gutentags',
    config = function()
      vim.g.gutentags_file_list_command = 'rg --files'
    end
  },
}
