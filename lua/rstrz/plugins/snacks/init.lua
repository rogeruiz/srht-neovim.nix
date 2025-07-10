return {
  'snacks.nvim',
  for_cat = "general.always",
  event = "UIEnter",
  lazy = false,
  load = function (name)
    vim.cmd.packadd(name)
    vim.cmd.packadd("alpha-nvim")
  end,
  after = function(plugin)
    require('snacks').setup {
      animate = { enabled = false },
      bigfile = { enabled = true },
      dashboard = require("rstrz.plugins.snacks.dashboard"),
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = false },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
    }
  end
}
