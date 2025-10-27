return {
  "kulala.nvim",
  for_cat = 'general.kulala',
  load = function(name)
    vim.cmd.packadd(name)
  end,
  ft = { "http", "rest" },
  after = function()
    require("kulala").setup({
      curl_path = vim.env.KULALA_CURL_PATH,
      openssl_path = vim.env.KULALA_OPENSSL_PATH,
      global_keymaps_prefix = "<leader>R",
      global_keymaps = true,
      ui = {
        max_response_size = 5120 * 1024, -- 5 MB
      }
    })
  end,
}
