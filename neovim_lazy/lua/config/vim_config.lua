vim.o.hidden = true
vim.o.autochdir = false
vim.o.hlsearch = false
vim.o.cindent = true
vim.o.shiftwidth=2
vim.o.ignorecase = true
vim.o.wrap = false
vim.o.belloff = 'all'
vim.o.showmode = false
vim.o.lazyredraw = true
vim.o.updatetime = 100
vim.o.laststatus = 2
vim.o.bg = 'light'
vim.o.termguicolors = true
vim.o.shortmess = 'filnxtToOFc'    -- Shut off completion messages
vim.o.mouse = 'a'
vim.wo.number = true
vim.wo.relativenumber = true
vim.bo.softtabstop = 2
vim.bo.smartindent = true
vim.bo.expandtab = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.showtabline = 2
vim.o.guifont = 'Iosevka:h12'

-- better vim temp file handling
vim.o.backup = true
vim.o.backupdir = vim.env.HOME .. '/.vim/files/backup/'
vim.o.backupext = '-vimbackup'
vim.o.backupskip = '$TMPDIR/*,$TMP/*,$TEMP/*,.env'
vim.o.directory = vim.env.HOME .. '/.vim/files/swap/'
vim.o.updatecount = 100
vim.o.undofile = true
vim.o.undodir = vim.env.HOME .. '/.vim/files/undo/'
vim.api.nvim_command("set viminfo='100,n$HOME/.vim/files/info/viminfo")

if vim.g.neovide then
  vim.o.guifont = 'Iosevka:h16'
  vim.g.neovide_padding_top = 20
  vim.g.neovide_padding_bottom = 20
  vim.g.neovide_padding_right = 20
  vim.g.neovide_padding_left = 20
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_floating_shadow = false
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
end

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Disable swap and undo for some files
vim.api.nvim_exec(
  [[
  augroup DisableSwapAndUndo
    autocmd!
    autocmd BufEnter .env silent! :set noswapfile
    autocmd BufEnter .env silent! :set noundofile
  augroup end
]],
  false
)

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('n', 'vv', '<c-w>v', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ee', ':tabe $MYVIMRC<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>es', ':source $MYVIMRC<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '[q', ':cp<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', ']q', ':cn<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', { noremap = true })
