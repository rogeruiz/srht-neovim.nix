return {
  'catppuccin',
  for_cat = 'catppuccin',
  cmd = { "Catppuccin" },
  keys = {
    -- vim.keymap.set("n", "<leader>ctl", "<cmd>Catppuccin latte<CR>", { desc = "[C]ambiar [T]ema [L]atte" })
    -- vim.keymap.set("n", "<leader>ctm", "<cmd>Catppuccin mocha<CR>", { desc = "[C]ambiar [T]ema [M]ocha" })
  },
  load = function (name)
    vim.cmd.packadd(name)
  end,
  after = function (plugin)
    vim.o.termguicolors = true;
    vim.o.background = "dark"
    -- Mejor soporte de colores y estilos usando a `terminfo`
    vim.cmd([[
      " Styled and colored underline support
      let &t_AU = "\e[58:5:%dm"
      let &t_8u = "\e[58:2:%lu:%lu:%lum"
      let &t_Us = "\e[4:2m"
      let &t_Cs = "\e[4:3m"
      let &t_ds = "\e[4:4m"
      let &t_Ds = "\e[4:5m"
      let &t_Ce = "\e[4:0m"
      " Strikethrough
      let &t_Ts = "\e[9m"
      let &t_Te = "\e[29m"
      " Truecolor support
      let &t_8f = "\e[38:2:%lu:%lu:%lum"
      let &t_8b = "\e[48:2:%lu:%lu:%lum"
      let &t_RF = "\e]10;?\e\\"
      let &t_RB = "\e]11;?\e\\"
      " Bracketed paste
      let &t_BE = "\e[?2004h"
      let &t_BD = "\e[?2004l"
      let &t_PS = "\e[200~"
      let &t_PE = "\e[201~"
      " Cursor control
      let &t_RC = "\e[?12$p"
      let &t_SH = "\e[%d q"
      let &t_RS = "\eP$q q\e\\"
      let &t_SI = "\e[5 q"
      let &t_SR = "\e[3 q"
      let &t_EI = "\e[1 q"
      let &t_VS = "\e[?12l"
      " Focus tracking
      let &t_fe = "\e[?1004h"
      let &t_fd = "\e[?1004l"
      execute "set <FocusGained>=\<Esc>[I"
      execute "set <FocusLost>=\<Esc>[O"
      " Window title
      let &t_ST = "\e[22;2t"
      let &t_RT = "\e[23;2t"

      " vim hardcodes background color erase even if the terminfo file does
      " not contain bce. This causes incorrect background rendering when
      " using a color theme with a background color in terminals such as
      " kitty that do not support background color erase.
      let &t_ut=''
        ]])
    -- Establecer el color de fondo del tema más temprano
    require('catppuccin').setup {
      flavour = 'auto',
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      show_end_of_buffer = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.10,
      },
      no_italic = false,    -- Force no italic
      no_bold = false,      -- Force no bold
      no_underline = false, -- Force no underline
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "italic" },
        keywords = {},
        strings = { "bold" },
        variables = {},
        numbers = { "bold" },
        booleans = { "italic" },
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          -- Change color for line numbers in general
          LineNr              = { fg = colors.overlay1, bold = false, },
          -- Change color for line numbers when CursorLine is enabled
          CursorLineNr        = { fg = colors.mauve, bold = true, },
          -- Change colors for relative line numbers above & below current line
          LineNrAbove         = { fg = colors.overlay1, },
          LineNrBelow         = { fg = colors.overlay1, },
          CursorLine          = { bg = colors.crust, },
          ColorColumn         = { bg = colors.mantle, },
          Search              = { bg = colors.teal, fg = colors.base },
          CurSearch           = { bg = colors.teal, fg = colors.base },
          FloatShadow         = { bg = colors.mauve, fg = colors.blue },
          FloatShadowThrough  = { bg = colors.mauve, fg = colors.blue },
          -- Pa' DadBod UI (https://github.com/kristijanhusak/vim-dadbod-ui)
          NotificationInfo    = { bg = colors.crust, fg = colors.overlay2 },
          NotificationWarning = { bg = colors.yellow, fg = colors.base },
          NotificationError   = { bg = colors.red, fg = colors.base },
          -- Pa' Lualine (https://github.com/nvim-lualine/lualine.nvim)
          LualineActiveTab    = { bg = colors.mauve, fg = colors.mantle },
          LualineInactiveTab  = { bg = colors.mantle, fg = colors.mauve },
          -- Pa' Zen Mode (https://github.com/folke/zen-mode.nvim)
          ZenBg               = { bg = colors.none },
          -- Pa' todotxt.nvim y treesitter todotxt
          todo_txt_date       = { fg = colors.subtext0 },
          todo_txt_pri_a      = { fg = colors.red },
          todo_txt_pri_b      = { fg = colors.green },
          todo_txt_pri_c      = { fg = colors.yellow },
          todo_txt_pri_d      = { fg = colors.blue },
          todo_txt_context    = { fg = colors.yellow },
          todo_txt_project    = { fg = colors.mauve },
          todo_txt_done_task  = { fg = colors.overlay0 },

        }
      end,
      integrations = {
        alpha = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        fidget = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = {
          enabled = true,
          scope_color = "overlay0",
          colored_indent_levels = true,
        },
        lsp_trouble = true,
        markdown = true,
        mason = true,
        mini = false,
        navic = true,
        neotree = true,
        noice = true,
        rainbow_delimiters = true,
        telescope = true,
        telekasten = true,
        which_key = true,
        window_picker = true,
        treesitter = true,
        native_lsp = {
          enable = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
      },
      highlight_overrides = {
        all = function(cp)
          return {
            -- For fidget.
            FidgetTask = { bg = cp.none, fg = cp.overlay0 },
            FidgetTitle = { fg = cp.blue, style = { "bold" } },
          }
        end,
      },
    }
  end
}
