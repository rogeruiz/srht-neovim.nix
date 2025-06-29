return {
    "which-key.nvim",
    for_cat = 'general.extra',
    -- cmd = { "" },
    event = "DeferredUIEnter",
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    after = function(plugin)
      require('which-key').setup({
      })
      require('which-key').add {
        { "<leader><leader>",  group = "comandos pa' búfer" },
        { "<leader><leader>_", hidden = true },
        { "<leader>c",         group = "[c]ódigo" },
        { "<leader>c_",        hidden = true },
        { "<leader>d",         group = "[d]ocumento" },
        { "<leader>d_",        hidden = true },
        { "<leader>g",         group = "[g]it" },
        { "<leader>g_",        hidden = true },
        { "<leader>m",         group = "[m]arkdown" },
        { "<leader>m_",        hidden = true },
        { "<leader>r",         group = "[r]enombrar" },
        { "<leader>r_",        hidden = true },
        { "<leader>b",         group = "[b]uscar" },
        { "<leader>s_",        hidden = true },
        { "<leader>t",         group = "[t]erminal" },
        { "<leader>t_",        hidden = true },
        { "<leader>j",         group = "área de traba[j]o" },
        { "<leader>j_",        hidden = true },
      }
    end,
  }
