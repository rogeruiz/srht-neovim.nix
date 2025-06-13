local base_dir = '/Users/yo/Dropbox/zettelkasten'

return {
  'telekasten.nvim',
  for_cat = '',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'folke/zen-mode.nvim',
  },
  on_require = { 'telekasten.nvim' },
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
      "<leader>zbg",
      "<cmd>Telekasten search_notes<CR>",
      mode = { "n" },
      desc = "[Z]ettelkasten: [b]uscar notas con [g]rep",
    },
  },
  opts = {
    home = base_dir,
    -- dailies = base_dir .. '/_dailies',
    -- weeklies = base_dir .. '/_weeklies',
    auto_set_filetype = false,
    -- vaults = {
    --   personal = {
    --     home = base_dir .. '/_personal',
    --   },
    --   comedy = {
    --     home = base_dir .. '/_comedy',
    --   },
    --   skylight = {
    --     home = base_dir .. '/_skylight',
    --   }
    -- },
    image_link_style = "markdown",
    command_palette_theme = "dropdown",
    show_tags_theme = "get_cursor",
  },
  init = function()
    -- Most used functions
    vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>", { desc = "Buscar notas" })
    vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten find_daily_notes<CR>", { desc = "Buscar notas del dia" })
    vim.keymap.set("n", "<leader>zw", "<cmd>Telekasten find_weekly_notes<CR>", { desc = "Buscar notas de la semana" })
    vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>", { desc = "Buscar contenido de notas" })
    vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>", { desc = "Seguir enlace" })
    vim.keymap.set("n", "<leader>zrn", "<cmd>Telekasten rename_note<CR>", { desc = "Seguir enlace" })
    vim.keymap.set("n", "<leader>zT", "<cmd>Telekasten goto_today<CR>", { desc = "Vaya a hoy" })
    vim.keymap.set("n", "<leader>zW", "<cmd>Telekasten goto_thisweek<CR>", { desc = "Vaya a esta semana" })
    vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>", { desc = "Nueva nota" })
    vim.keymap.set("n", "<leader>zN", "<cmd>Telekasten new_note_templated_note<CR>", { desc = "Nueva nota de plantilla" })
    vim.keymap.set("n", "<leader>zy", "<cmd>Telekasten yank_notelink<CR>", { desc = "Tira el enlace de la nota" })
    vim.keymap.set("n", "<leader>zI", "<cmd>lua require('telekasten').insert_img_link({ i = true})<CR>",
      { desc = "Insertar enlace de imagen" })
    vim.keymap.set("n", "<leader>zi", "<cmd>Telekasten paste_img_and_link<CR>", { desc = "Pegar enlace y imagen" })
    vim.keymap.set("n", "<leader>zt", "<cmd>Telekasten toggle_todo<CR>", { desc = "Alternar 'todo'" })
    vim.keymap.set("v", "<leader>zt", "<cmd>lua require('telekasten').toggle_todo({v = true})<CR>",
      { desc = "Alternar 'todo'" })
    vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", { desc = "Mostrar enlaces atrasados" })
    vim.keymap.set("n", "<leader>zF", "<cmd>Telekasten find_friends<CR>", { desc = "Buscar notas relacionadas" })
    vim.keymap.set("n", "<leader>zm", "<cmd>Telekasten browse_media<CR>", { desc = "Navigar por los medios" })
    vim.keymap.set("n", "<leader>z#", "<cmd>Telekasten show_tags<CR>", { desc = "Mostrar etiquetas" })
    vim.keymap.set("n", "<leader>zs", "<cmd>Telekasten switch_vault<CR>", { desc = "Cambiar de bóveda" })

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

    vim.keymap.set("n", "<leader>zm", "<cmd>ZenMode<cr>")
  end
}

