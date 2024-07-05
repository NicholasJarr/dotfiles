vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', { noremap = true })

function create_augroup(autocmds, name)
  vim.cmd('augroup ' .. name)
  vim.cmd('autocmd!')
  for _, autocmd in ipairs(autocmds) do
    vim.cmd('autocmd ' .. table.concat(autocmd, ' '))
  end
  vim.cmd('augroup END')
end

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

create_augroup({
  { 'TermOpen', '*', 'nnoremap <buffer> . i<Up><cr><c-\\><c-n>G' },
  { 'TermOpen', 'term://*', 'lua set_terminal_keymaps()' },
}, 'terminal_commands')
