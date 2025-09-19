return {
  {
    'tiny-glimmer-nvim',
    for_cat = "general.anime",
    event = "UIEnter",
    lazy = false,
    after = function()
      require('tiny-glimmer').setup({
        enabled = true,
      })
    end
  },
  {
    'smoothcursor-nvim',
    for_cat = "general.anime",
    event = "UIEnter",
    lazy = false,
    after = function()
      require('smoothcursor').setup({})
    end
  },
  {
    'nvim-luxmotion',
    for_cat = "general.anime",
    event = "UIEnter",
    lazy = false,
    after = function()
      require('luxmotion').setup({})
    end

  },
  {
    'specs.nvim',
    for_cat = "general.anime",
    event = "UIEnter",
    lazy = false,
    after = function()
      require('specs').setup {
        show_jumps       = true,
        min_jump         = 30,
        popup            = {
          delay_ms = 0, -- delay before popup displays
          inc_ms = 10,  -- time increments used for fade/resize effects
          blend = 10,   -- starting blend, between 0-100 (fully transparent), see :h winblend
          width = 10,
          winhl = "PMenu",
          fader = require('specs').linear_fader,
          resizer = require('specs').shrink_resizer
        },
        ignore_filetypes = {},
        ignore_buftypes  = {
          nofile = true,
        },
      }
    end
  }
}
