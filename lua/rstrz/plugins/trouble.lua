return {
  "trouble.nvim",
  for_cat = 'general.extra',
  event = 'DeferredUIEnter',
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnósticos (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Diagnósticos del Búfer (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble lsp_document_symbols toggle focus=false<cr>",
      desc = "Simbolos (Trouble)",
    },
    {
      "<leader>cl",
      "<m>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP definaciones / referencias / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Lista de localaciones (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Lisa Quickfix (Trouble)",
    },
  },
}
