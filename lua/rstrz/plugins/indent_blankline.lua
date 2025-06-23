return {
  'indent-blankline.nvim',
  for_cat = "general.always",
  event = "DeferredUIEnter",
  load = function(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd('indent-rainbowline')
  end,
  after = function()
    local colors = require("catppuccin.palettes").get_palette()
    local icons = require('rstrz.icons')

    local highlight = {
      "RainbowRed",
      "RainbowOrange",
      "RainbowYellow",
      "RainbowGreen",
      "RainbowBlue",
      "RainbowCyan",
      "RainbowViolet",
    }

    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = colors.red })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = colors.yellow })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = colors.blue })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = colors.peach })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = colors.green })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = colors.mauve })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = colors.sky })
    end)
    -- opt.list = true
    -- opt.listchars:append("space:")
    -- opt.listchars:append("eol:󰌑")
    --

    local finalOpts = {
      indent = {
        highlight = highlight,
        char = icons.git.ui.add,
      },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      -- color_transparency = 0.35,
      scope = {
        -- highlight = highlight,
        -- char = "┊",
        char = icons.git.ui.change,
      },
      exclude = {
        filetypes = {
          "alpha",
          "neo-tree",
        },
      },
    }

    require("ibl").setup(finalOpts)
  end,
}
