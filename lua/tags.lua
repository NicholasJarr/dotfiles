-- gutentags
vim.g.gutentags_file_list_command = 'rg --files'

-- tagbar
vim.g.tagbar_type_ruby = {
  kinds = {
    'm:modules',
    'c:classes',
    'd:describes',
    'C:contexts',
    'f:methods',
    'F:singleton methods'
  }
}
if vim.fn.executable('ripper-tags') == 1 then
  vim.g.tagbar_type_ruby = {
    kinds = {
      'm:modules',
      'c:classes',
      'C:constants',
      'd:describes',
      'x:contexts',
      'F:singleton methods',
      'f:methods',
      'a:aliases'
    },
    kind2scope = { c = 'class', m = 'class' },
    scope2kind = { class = 'c' },
    ctagsbin = 'ripper-tags',
    ctagsargs = { '-f', '-' }
  }
end
