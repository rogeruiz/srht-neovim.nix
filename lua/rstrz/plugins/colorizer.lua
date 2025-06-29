return {
  "colorizer",
  for_cat = "general.extra",
  event = "DeferredUIEnter",
  keys = {
    { "<leader>cp", '<CMD>:ColorizerToggle<CR>', mode = { "n" }, desc = '[C]olorizer [p]alanca' },
    { "<leader>cr", '<CMD>:ColorizerReloadAllBuffers<CR>', mode = { "n" }, desc = '[C]olorizer [r]eniciar todos búfers' },
  },
  after = function()
    require("colorizer").setup({
      '*',
      '!vim',
      '!help',
      '!toggleterm',
    })
  end
}
