local on_open = function(term)
  vim.cmd("startinsert!")
  vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
end

local on_close = function(_)
  vim.cmd("startinsert!")
end

local function merge_options(orig, config)
  local result = {}
  for key, value in pairs(orig) do
    result[key] = value
  end
  for key, value in pairs(config) do
    result[key] = value
  end
  return result
end

local dash_config = {
  hidden = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
  -- function to run on opening the terminal
  on_open = on_open,
  -- function to run on closing the terminal
  on_close = on_close,
}

local logs_config = {
  hidden = true,
  direction = 'horizontal',
  close_on_exit = true,
  -- function to run on opening the terminal
  on_open = on_open,
  -- function to run on closing the terminal
  on_close = on_close,
}

require('lze').load {
  {
    'toggleterm.nvim',
    for_cat = 'general.always',
    -- on_require = { "toggleterm" },
    -- on_plugin = 'plenary.nvim',
    load = function (name)
      vim.cmd.packadd(name)
      vim.cmd.packadd('plenary.nvim')
    end,
    after = function()
      require('toggleterm').setup({})

      local Terminal = require('toggleterm.terminal').Terminal

      local cpu_usage = Terminal:new(merge_options(dash_config, {
        cmd = 'btm --default_widget_type cpu --expanded --current_usage --hide_avg_cpu',
        float_opts = {
          width = 64,
          height = 22,
        },
      }))

      local console = Terminal:new(merge_options(dash_config, {}))
      local tools = Terminal:new(merge_options(logs_config, {}))
      local git = Terminal:new(merge_options(logs_config, {
        direction = 'vertical',
        goback = 0,
      }))
      local gh = Terminal:new(merge_options(dash_config, {}))

      vim.keymap.set('n', '<leader>tf', function()
          console.float_opts = merge_options(console.float_opts, {
            width = math.floor(vim.o.columns * 0.85),
            height = math.floor(vim.o.lines * 0.85),
          })
          console:toggle()
        end,
        { desc = "Abrir [T]erminal [F]lotante" })
      vim.keymap.set('n', '<leader>tt', function()
          local size = math.floor(vim.o.lines * 0.35)
          tools:toggle(size)
        end,
        { desc = "Abrir [T]erminal para usar [T]ools" })
      vim.keymap.set('n', '<leader>tc', function()
          cpu_usage:toggle()
        end,
        { desc = "Abrir [T]erminal para ver [C]PU" })

      --  _                         _         _                _
      -- | |_ ___ ___ ___ ___ _____|_|___ ___| |_ ___ ___    _| |___
      -- |   | -_|  _|  _| .'|     | | -_|   |  _| .'|_ -|  | . | -_|
      -- |_|_|___|_| |_| |__,|_|_|_|_|___|_|_|_| |__,|___|  |___|___|
      --  _____ _ _
      -- |   __|_| |_
      -- |  |  | |  _|
      -- |_____|_|_|
      local gh_dash = Terminal:new(merge_options(dash_config, {
        cmd = 'gh dash',
      }))
      local git_width = 100

      vim.keymap.set('n', '<leader>tgs', function()
          local cmd = 'git status'
          git:open(git_width)
          git:send(cmd, false)
          git:focus()
        end,
        { desc = "[G]it [S]tatus" })
      vim.keymap.set('n', '<leader>tgco', function()
          local cmd = 'git commit -v'
          git:open(git_width)
          git:send(cmd, false)
          git:focus()
        end,
        { desc = "[G]it [C][o]mete" })
      vim.keymap.set('n', '<leader>tga', function()
          local cmd = 'git add --patch'
          git:open(git_width)
          git:send(cmd, false)
          git:focus()
        end,
        { desc = "[G]it [A]dd en parcha" })
      vim.keymap.set('n', '<leader>tghd', function()
          gh_dash.float_opts = merge_options(gh_dash.float_opts, {
            width = math.floor(vim.o.columns * 0.85),
            height = math.floor(vim.o.lines * 0.75),
          })
          gh_dash:toggle()
          gh_dash:focus()
        end,
        { desc = "[G]it[H]ub CLI [D]ashboard" })
      vim.keymap.set('n', '<leader>tghpr', function()
          local cmd = 'gh pr create'
          gh.float_opts = merge_options(gh.float_opts, {
            width = math.floor(vim.o.columns * 0.85),
            height = math.floor(vim.o.lines * 0.75),
          })
          gh:open()
          gh:send(cmd, false)
          gh:focus()
        end,
        { desc = "[G]it[H]ub CLI [P]ull [R]equest" })
      vim.keymap.set('n', '<leader>tgprb', function()
          local user_input = vim.fn.input("🎯 Nobre de la rama pa'l base objetivo: ")
          local cmd = 'gh pr create --base ' .. user_input
          gh.float_opts = merge_options(gh.float_opts, {
            width = math.floor(vim.o.columns * 0.85),
            height = math.floor(vim.o.lines * 0.75),
          })
          gh:open()
          gh:send(cmd, false)
          gh:focus()
        end,
        { desc = "[G]it[H]ub CLI [P]ull [R]equest con base personalizada" })
    end
  }
}
