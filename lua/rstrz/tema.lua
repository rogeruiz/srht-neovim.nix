---@diagnostic disable: need-check-nil
local handle = io.popen("defaults read -g AppleInterfaceStyle")
local result = handle:read("*a")
handle:close()

if string.find(result, "Dark") then
  vim.o.background = 'dark'
else
  vim.o.background = 'light'
end

if nixCats('themer.catppuccin') then
  vim.g.loaded_netrwPlugin = 1
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
      variables = { },
      numbers = { "bold" },
      booleans = { "italic", "bold" },
      properties = { "italic" },
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = function(colors)
      return {
        Cursor              = { bg = colors.crust, fg = colors.overlay2 },
        lCursor             = { bg = colors.crust, fg = colors.overlay2 },
        CursorIM            = { bg = colors.crust, fg = colors.overlay2 },
        -- Change color for line numbers in general
        LineNr              = { fg = colors.overlay1, bold = false, },
        -- Change color for line numbers when CursorLine is enabled
        CursorLineNr        = { fg = colors.mauve, bold = true, },
        -- Change colors for relative line numbers above & below current line
        LineNrAbove         = { fg = colors.overlay1, },
        LineNrBelow         = { fg = colors.overlay1, },
        CursorLine          = { bg = colors.crust, },
        ColorColumn         = { bg = colors.mantle, },
        Search              = { bg = colors.yellow, fg = colors.base },
        CurSearch           = { bg = colors.yellow, fg = colors.base },
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
        -- Pa' Notify
        NotifyBackground    = { bg = colors.mantle },

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
      snacks = {
        enabled = true,
        indent_scope_color = "mauve",
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

  vim.cmd.colorscheme('catppuccin')

  vim.keymap.set('n', '<leader>ctl', '<cmd>Catppuccin latte<cr>',
    { noremap = true, silent = true, desc = '[C]ambiar [t]ema a Catppuccin [l]atte' })
  vim.keymap.set('n', '<leader>ctm', '<cmd>Catppuccin mocha<cr>',
    { noremap = true, silent = true, desc = '[C]ambiar [t]ema a Catppuccin [m]ocha' })
end
