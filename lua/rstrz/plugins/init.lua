local ok, notify = pcall(require, "notify")
if ok then
  notify.setup({
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { focusable = false })
    end,
  })
  vim.notify = notify
  vim.keymap.set("n", "<Esc>", function()
    notify.dismiss({ silent = true, })
  end, { desc = "dismiss notify popup and clear hlsearch" })
end

-- NOTE: you can check if you included the category with the thing wherever you want.
if nixCats('general.extra') then
  -- I didnt want to bother with lazy loading this.
  -- I could put it in opt and put it in a spec anyway
  -- and then not set any handlers and it would load at startup,
  -- but why... I guess I could make it load
  -- after the other lze definitions in the next call using priority value?
  -- didnt seem necessary.
  vim.g.loaded_netrwPlugin = 1
  require("oil").setup({
    default_file_explorer = true,
    view_options = {
      show_hidden = true
    },
    columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
    },
    keymaps = {
      ["g?"] = { "actions.show_help", desc = "Mostrar ayuda" },
      ["<CR>"] = { "actions.select", desc = "Abrire el elemento debajo del cursor" },
      ["<C-v>"] = { "actions.select_vsplit", desc = "Abrire el elemento debajo del cursor vertical" },
      ["<C-x>"] = { "actions.select_split", desc = "Abrire el elemento debajo del cursor horizontal" },
      ["<C-t>"] = { "actions.select_tab", desc = "Abrire el elemento debajo del cursor en un nuevo tab" },
      ["<C-p>"] = { "actions.preview", desc = "Alternar abrire el elemento in vista previa" },
      ["<C-c>"] = { "actions.close", desc = "Ciere y vuelva al búfer anterior" },
      ["<C-l>"] = { "actions.refresh", desc = "Actualize el directorio corriente" },
      ["-"] = { "actions.parent", desc = "Navigar a la carpeta arriba" },
      ["_"] = { "actions.open_cwd", desc = "Abrir el directorio corriente de Neovim" },
      ["`"] = { "actions.cd", desc = ":cd a la actual carpeta de oil" },
      ["~"] = { "actions.tcd", desc = ":tcd a la actual carpeta de oil" },
      ["gs"] = { "actions.change_sort", desc = "Cambia el orden de archivos" },
      ["gx"] = { "actions.open_external", desc = "Abrier el elemento debajo del cursor in programa externo" },
      ["g."] = { "actions.toggle_hidden", desc = "Alternar mostrar archivos ocultos" },
      ["g\\"] = { "actions.toggle_trash", desc = "Alternar mostrar basurero" },
    },
  })
  vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true, desc = 'Abrir la carpeta anterior' })
  vim.keymap.set("n", "<leader>-", "<cmd>Oil .<CR>", { noremap = true, desc = 'Abrir la raiz carpeta de nvim' })
end

require('lze').load {
  { import = "rstrz.plugins.snacks", },
  { import = "rstrz.plugins.telescope", },
  { import = "rstrz.plugins.treesitter", },
  { import = "rstrz.plugins.completion", },
  { import = "rstrz.plugins.lualine", },
  { import = "rstrz.plugins.navic", },
  { import = "rstrz.plugins.indent_blankline", },
  { import = "rstrz.plugins.colorizer", },
  { import = "rstrz.plugins.autopairs", },
  { import = "rstrz.plugins.matchup", },
  { import = "rstrz.plugins.ufo", },
  { import = "rstrz.plugins.trouble", },
  { import = "rstrz.plugins.todo-comments", },
  {
    "markdown-preview.nvim",
    -- NOTE: for_cat is a custom handler that just sets enabled value for us,
    -- based on result of nixCats('cat.name') and allows us to set a different
    -- default if we wish it is defined in luaUtils template in
    -- lua/nixCatsUtils/lzUtils.lua you could replace this with enabled =
    -- nixCats('cat.name') == true if you didnt care to set a different default
    -- for when not using nix than the default you already set
    for_cat = 'general.markdown',
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle", },
    ft = "markdown",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview <CR>",       mode = { "n" }, noremap = true, desc = "markdown preview" },
      { "<leader>ms", "<cmd>MarkdownPreviewStop <CR>",   mode = { "n" }, noremap = true, desc = "markdown preview stop" },
      { "<leader>mt", "<cmd>MarkdownPreviewToggle <CR>", mode = { "n" }, noremap = true, desc = "markdown preview toggle" },
    },
    before = function(plugin)
      vim.g.mkdp_auto_close = 0
    end,
  },
  {
    "undotree",
    for_cat = 'general.extra',
    cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotreePersistUndo", },
    keys = { { "<leader>U", "<cmd>UndotreeToggle<CR>", mode = { "n" }, desc = "[U]ndo arbol de cambios" }, },
    before = function(_)
      vim.g.undotree_WindowLayout = 1
      vim.g.undotree_SplitWidth = 40
    end,
  },
  {
    "comment.nvim",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    after = function(plugin)
      require('Comment').setup()
    end,
  },
  {
    "nvim-surround",
    for_cat = 'general.always',
    event = "DeferredUIEnter",
    -- keys = "",
    after = function(plugin)
      require('nvim-surround').setup()
    end,
  },
  {
    "vim-startuptime",
    for_cat = 'general.extra',
    cmd = { "StartupTime" },
    before = function(_)
      vim.g.startuptime_event_width = 0
      vim.g.startuptime_tries = 10
      vim.g.startuptime_exe_path = nixCats.packageBinPath
    end,
  },
  {
    "todo.txt-vim",
    for_cat = 'general.extra',
  },
  -- {
  --   "avante.nvim",
  --   for_cat = "general.llm",
  --   load = function(name)
  --     vim.cmd.packadd(name)
  --     vim.cmd.packadd('nui.nvim')
  --     vim.cmd.packadd('mini.icons')
  --   end,
  --   after = function()
  --     require("avante").setup({
  --       provider = "gemini",
  --       providers = {
  --         gemini = {
  --           model = "gemini-2.5-flash-lite"
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "fidget.nvim",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    -- keys = "",
    after = function(plugin)
      require('fidget').setup({})
    end,
  },
  {
    "hlargs",
    for_cat = 'general.extra',
    event = "DeferredUIEnter",
    -- keys = "",
    dep_of = { "nvim-lspconfig" },
    after = function(plugin)
      require('hlargs').setup {
        color = '#32a88f',
      }
      vim.cmd([[hi clear @lsp.type.parameter]])
      vim.cmd([[hi link @lsp.type.parameter Hlargs]])
    end,
  },
  { import = "rstrz.plugins.gitsigns" },
  { import = "rstrz.plugins.which-key" },
}
