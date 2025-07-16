require('lze').load {
  {
    "conform.nvim",
    for_cat = 'format',
    -- cmd = { "" },
    -- event = "",
    -- ft = "",
    keys = {
      { "<leader>FF", desc = "[F]ormat [F]ile" },
    },
    -- colorscheme = "",
    after = function (plugin)
      local conform = require("conform")

      conform.setup({
        stop_after_first = true,
        formatters_by_ft = {
          -- NOTE: download some formatters in lspsAndRuntimeDeps
          -- and configure them here
          lua = { "stylua" },
          go = { "gofmt", "golint" },
          typescriptreact = { "prettierd", "prettier" },
          -- templ = { "templ" },
          -- Conform will run multiple formatters sequentially
          python = { "mypy", "ruff" },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>FF", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "[F]ormat [F]ile" })
    end,
  },
}
