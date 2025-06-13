require('lze').load {
  'telekasten.nvim',
  for_cat = 'general.extra',
  on_plugin = {
    "alpha-nvim",
  },
  load = function(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd('telescope.nvim')
    vim.cmd.packadd('zen-mode.nvim')
  end,
  keys = {
    {
      "<leader>zbn",
      "<cmd>Telekasten find_notes<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [b]uscar [n]otas",
    },
    {
      "<leader>zbh",
      "<cmd>Telekasten find_daily_notes<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [b]uscar notas de [h]oy",
    },
    {
      "<leader>zbs",
      "<cmd>Telekasten find_weekly_notes<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [b]uscar notas de la [s]emana",
    },
    {
      "<leader>zbg",
      "<cmd>Telekasten search_notes<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [b]uscar notas con [g]rep",
    },
    {
      "<leader>zse",
      "<cmd>Telekasten follow_link<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [s]eguir [e]nlace",
    },
    {
      "<leader>zrn",
      "<cmd>Telekasten rename_note<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [r]enombrar [n]ota",
    },
    {
      "<leader>zvH",
      "<cmd>Telekasten goto_today<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [v]aya a la nota de [h]oy",
    },
    {
      "<leader>zvS",
      "<cmd>Telekasten goto_thisweek<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [v]aya a la nota de la [s]emana",
    },
    {
      "<leader>zn",
      "<cmd>Telekasten new_note<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [n]ueva nota",
    },
    {
      "<leader>za",
      "<cmd>Telekasten show_backlinks<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: mostrar enlaces [a]trasados",
    },
    {
      "<leader>zy",
      "<cmd>Telekasten yank_notelink<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: Tira ([Y]ank) el enlace de la nota actual",
    },
    {
      "<leader>z#",
      "<cmd>Telekasten show_tags<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: mostrar [#]etiquetas",
    },
    {
      "<leader>zbr",
      "<cmd>Telekasten find_friends<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [b]uscar notas [r]elacionadas",
    },
    {
      "<leader>zn",
      "<cmd>Telekasten new_note<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [n]ueva nota",
    },
    {
      "<leader>zm",
      "<cmd>ZenMode<CR>",
      mode = { "n" },
      desc = "[Z]en[m]ode",
    },
  },
  after = function()
    require("telekasten").setup({
      home = '/Users/yo/Dropbox/zettelkasten',
      auto_set_filetype = false,
      image_link_style = "markdown",
      command_palette_theme = "dropdown",
      show_tags_theme = "get_cursor",
    })
    require("zen-mode").setup({
      tmux = { enabled = true },
      window = {
        backdrop = 0.4,
        width = 0.85,
        height = 0.85,
      },
      plugins = {
        gisigns = {
          enabled = true,
        },
        tmux = {
          enabled = true,
        },
      },
    })
  end
}
