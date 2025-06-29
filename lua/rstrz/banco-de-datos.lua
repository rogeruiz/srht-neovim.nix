require('lze').load {
  'vim-dadbod-ui',
  for_cat = 'general.database',
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  load = function(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd('vim-dadbod')
    vim.cmd.packadd('vim-dadbod-completion')
  end,
  after = function(plugin)
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
