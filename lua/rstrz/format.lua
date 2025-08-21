require('lze').load {
  {
    "conform.nvim",
    for_cat = 'format',
    -- cmd = { "" },
    event = "UIEnter",
    -- ft = "",
    keys = {
      { "<leader>FF", desc = "[F]ormat [F]ile" },
    },
    -- colorscheme = "",
    after = function( --[[ plugin ]])
      local conform = require("conform")
      local notify = require("notify")

      conform.setup({
        stop_after_first = true,
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 1000, lsp_fallback = true, }
        end,
        formatters_by_ft = {
          -- NOTE: download some formatters in lspsAndRuntimeDeps
          -- and configure them here
          lua = { "stylua" },
          go = { "gofmt", "golint" },
          typescriptreact = { "prettierd", "prettier" },
          -- templ = { "templ" },
          -- Conform will run multiple formatters sequentially
          python = { "mypy", "ruff" },
          markdown = { "prettierd" },
          css = { "prettierd" },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>FF", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "[F]ormat [F]ile" })

      local function show_notification(message, level)
        notify(message, level, { title = "conform.nvim" })
      end

      vim.api.nvim_create_user_command("FormatToggle", function(args)
        local is_global = not args.bang
        if is_global then
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          if vim.g.disable_autoformat then
            show_notification("El formato de archivos esta desactivado para todos archivos", "info")
          else
            show_notification("El formato de archivos esta activado para todos archivos", "info")
          end
        else
          vim.b.disable_autoformat = not vim.b.disable_autoformat
          if vim.b.disable_autoformat then
            show_notification("El formato de archivos esta desactivado para este búfer", "info")
          else
            show_notification("El formato de archivos esta activado para este búfer", "info")
          end
        end
      end, {
        desc = "Toggle autoformat-on-save",
        bang = true,
      })
    end,
  },
}
