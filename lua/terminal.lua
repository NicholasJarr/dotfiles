require("toggleterm").setup {
  open_mapping = [[<c-\>]],
}

vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', { noremap = true })

function create_augroup(autocmds, name)
  vim.cmd('augroup ' .. name)
  vim.cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  vim.cmd('augroup END')
end

create_augroup({
  { 'TermOpen', '*', 'nnoremap <buffer> . i<Up><cr><c-\\><c-n>G' },
}, 'terminal_commands')
