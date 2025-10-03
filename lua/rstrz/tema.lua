---@diagnostic disable: need-check-nil
local function get_system_theme()
  local os_name = vim.uv.os_uname().sysname

  if os_name == "Darwin" then
    local handle, result = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null"), nil
    if handle then
      result = handle:read("*a"):match("%S+")
      handle:close()
    end
    return result == "Dark" and "Dark" or "Light"
  elseif os_name == "Linux" then
    local handle, result = io.popen("gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null"), nil
    if handle then
      result = handle:read("*a"):lower()
      handle:close()
    end
    -- BUG: This only works if the GNOME theme has the word `mocha` in the name. This is not ideal.
    if result and result:find("mocha") then
      return "Dark"
    end
    return "Light"
  elseif os_name:find("Windows") then
    local handle, result =
        io.popen(
          "reg query \"HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize\" /v AppsUseLightTheme 2>nul | findstr REG_DWORD"),
        nil
    if handle then
      result = handle:read("*a"):match("0x(%d+)")
      handle:close()
    end
    return result == "0" and "Dark" or "Light"
  end

  return "Light" -- Default to Light if OS is not recognized
end

local interface_style = get_system_theme()
if interface_style and string.find(interface_style, "Dark") then
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
    float = {
      transparent = true,
    },
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
      variables = {},
      numbers = { "bold" },
      booleans = { "italic", "bold" },
      properties = { "italic" },
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = function(colors)
      return {
        Visual                           = { bg = colors.crust },
        IncSearch                        = { bg = colors.blue, fg = colors.peach },
        TermCursor                       = { bg = colors.blue, fg = colors.peach },
        Cursor                           = { bg = colors.blue, fg = colors.peach },
        lCursor                          = { bg = colors.blue, fg = colors.peach },
        CursorIM                         = { bg = colors.crust, fg = colors.overlay2 },
        -- Change color for line numbers in general
        LineNr                           = { fg = colors.overlay1, bold = false, },
        -- Change color for line numbers when CursorLine is enabled
        CursorLineNr                     = { fg = colors.mauve, bold = true, },
        -- Change colors for relative line numbers above & below current line
        LineNrAbove                      = { fg = colors.overlay1, },
        LineNrBelow                      = { fg = colors.overlay1, },
        CursorLine                       = { bg = colors.crust, },
        ColorColumn                      = { bg = colors.mantle, },
        Search                           = { fg = colors.yellow, bg = colors.blue },
        CurSearch                        = { fg = colors.peach, bg = colors.blue },
        -- FloatShadow         = { bg = colors.overlay0, fg = colors.blue },
        -- FloatShadowThrough  = { bg = colors.overlay0, fg = colors.blue },
        -- Pa' DadBod UI (https://github.com/kristijanhusak/vim-dadbod-ui)
        NotificationInfo                 = { bg = colors.crust, fg = colors.overlay2 },
        NotificationWarning              = { bg = colors.yellow, fg = colors.base },
        NotificationError                = { bg = colors.red, fg = colors.base },
        -- Pa' Lualine (https://github.com/nvim-lualine/lualine.nvim)
        LualineActiveTab                 = { bg = colors.mauve, fg = colors.mantle },
        LualineInactiveTab               = { bg = colors.mantle, fg = colors.mauve },
        -- Pa' Zen Mode (https://github.com/folke/zen-mode.nvim)
        ZenBg                            = { bg = colors.none },
        -- Pa' todotxt.nvim y treesitter todotxt
        todo_txt_date                    = { fg = colors.subtext0 },
        todo_txt_pri_a                   = { fg = colors.red },
        todo_txt_pri_b                   = { fg = colors.green },
        todo_txt_pri_c                   = { fg = colors.yellow },
        todo_txt_pri_d                   = { fg = colors.blue },
        todo_txt_context                 = { fg = colors.yellow },
        todo_txt_project                 = { fg = colors.mauve },
        todo_txt_done_task               = { fg = colors.overlay0 },
        -- Pa' Notify
        NotifyBackground                 = { bg = colors.mantle },
        -- Pa' Avante
        AvanteToBeDeletedWOStrikethrough = { fg = "#be1940", bg = "#e5a3b4" },
        -- NeogitDiffDeleteHighlight xxx guifg=#be1940 guibg=#e5a3b4                                                                   │                            │
        -- NeogitDiffAddHighlight xxx guifg=#429434 guibg=#b3d5af
      }
    end,
    integrations = {
      avante = true,
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
      mini = true,
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
          errors = { "undercurl" },
          hints = { "underdotted" },
          warnings = { "underdouble" },
          information = { "underdashed" },
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
