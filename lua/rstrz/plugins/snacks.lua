return {
  'snacks.nvim',
  for_cat = "general.always",
  event = "DeferredUIEnter",
  after = function(plugin)
    require('snacks').setup {
      animate = { enabled = false },
      -- animate = {
      --   duration = 15,
      --   fps = 30,
      --   easing = "outSine",
      -- },
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
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
