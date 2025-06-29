return {
  'nvimtools/none-ls.nvim',    -- for formatters and linters
  dependencies = {
    -- "williamboman/mason.nvim", -- simple to use language server installer
    -- "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local null_ls = require('null-ls')
    local null_ls_helpers = require('null-ls.helpers')

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    -- local code_actions = null_ls.builtins.code_actions
    -- local hover = null_ls.builtins.hover

    null_ls.setup({
      debug = false,
      update_on_insert = true,
      sources = {
        formatting.terraform_fmt,
        formatting.prettierd.with({
          filetypes = { 'json', 'css', 'javascriptreact', 'js', 'markdown', 'typescriptreact', 'typescript' }
        }),

        -- formatting.just,

        -- diagnostics.ruff,
        -- formatting.black,

        formatting.gofumpt,
        formatting.goimports_reviser.with({
          extra_args = { "-rm-unused" },
        }),
        formatting.golines,

        -- diagnostics.vale.with({
        --   args = function(params)
        --     return {
        --       -- '--config=/Users/yo/.config/vale/vale.ini',
        --       "--no-exit",
        --       "--output",
        --       "JSON",
        --       "--ext",
        --       "." .. vim.fn.fnamemodify(params.bufname, ":e"),
        --     }
        --   end,
        -- }),
      },
      -- Desactivando esto por ahora poque Neovim dice que no puede encontrar a `lsp.handlers`.
      -- on_attach = require("lsp.handlers").on_attach,
    })
  end
}
