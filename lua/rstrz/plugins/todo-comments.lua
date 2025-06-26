local icons = require("rstrz.icons")

return {
  'todo-comments.nvim',
  event = 'DeferredUIEnter',
  dep_of = {
    'plenary-nvim',
    'catppuccin-nvim',
  },
  -- TODO: I have to do this.
  -- FIX: I have to fix this.
  -- HACK: I want to hack on this.
  -- WARN: I read a warning about this.
  -- PERF: I think this is slow.
  -- NOTE: I have this note here.
  -- TEST: I like testing this.
  -- MARK: I have to remember this
  after = function()
    require('todo-comments').setup({
      signs = true,      -- show icons in the signs column
      sign_priority = 8, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = icons.ui.Bug,                        -- icon used for the sign, and in search results
          color = "error",                            -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = icons.diagnostics.Todo, color = "info" },
        HACK = { icon = icons.diagnostics.Hack, color = "error" },
        WARN = { icon = icons.diagnostics.Warning, color = "warning", alt = { "WARNING", "XXX", "AVISO" } },
        PERF = { icon = icons.diagnostics.Perf, color = "warning", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = icons.diagnostics.Information, color = "hint", alt = { "INFO", "README", "NOTA" } },
        TEST = { icon = icons.diagnostics.Test, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        MARK = { icon = icons.diagnostics.VirtualText, color = "info" },
      },
      gui_style = {
        fg = "ITALIC",       -- The gui style to use for the fg highlight group.
        bg = "ITALIC",       -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = true,                -- enable multine todo comments
        multiline_pattern = "^.",        -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
        before = "bg",                   -- "fg" or "bg" or empty
        keyword = "wide_bg",             -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",                    -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true,            -- uses treesitter to match keywords in comments only
        max_line_len = 400,              -- ignore lines longer than this
        exclude = {},                    -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg" },
        warning = { "DiagnosticWarning", "WarningMsg" },
        info = { "DiagnosticInfo" },
        hint = { "DiagnosticHint" },
        test = { "Identifier" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    })
  end,
}
