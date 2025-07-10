-- Vamos a siembra la aleatoriedad con la hora actual
math.randomseed(os.time())

---random_header returns a Figlet header from the custom Figlet headers I
---maintain in the rstrz.figlet_headers module.
---@return string # A random table for the header table from the rstrz.figlet_headers module
local function random_header_figlet()
  local headers = require("rstrz.figlet_headers")
  return headers[math.random(1, #headers)]
end

---pick_color returns a random color using the colors available in the current
---theme matched across String, Identifier, Keyword, and Number.
---@return string # A random color represented by highlight groups
local function pick_color()
  local colors = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
  }
  return colors[math.random(#colors)]
end

---This function returns the name of the current directory and the parent
---direcory and truncates the new path into two characters so it doesn't break
---the dashboard theme.
---@return string? wd The working directory
local function get_current_directory()
  local directory_length = 20
  -- Matches the last two directories.
  local wd = os.getenv("PWD"):match("^.+/(.+/.+)$")
  if wd == nil then
    return os.getenv("PWD")
  elseif #wd > directory_length then
    -- Truncates the second directory with three dots.
    wd = string.sub(wd, 0, directory_length) .. "..."
  end
  return wd
end

local icons = require("rstrz.icons")

return {
  row = nil,
  col = nil,
  pane_gap = 4,
  preset = {
    header = random_header_figlet(),
    keys = {
      { icon = icons.documents.File,   key = "n", desc = "[N]uevo archivo",            action = ":ene | startinsert" },
      { icon = icons.ui.Search,        key = "b", desc = "[B]usca archivos",           action = ":lua require('telescope.builtin').find_files({ hidden = true, prompt_title = 'Buscando archivos', })" },
      { icon = icons.ui.Search,        key = "t", desc = "Busca [t]exto",              action = ":lua require('telescope.builtin').live_grep({ hidden = true, prompt_title = 'Buscando con Grep', })" },
      { icon = icons.diagnostics.Todo, key = "r", desc = "Busca archivos [r]ecientes", action = ":lua require('telescope.builtin').oldfiles({ prompt_title = 'Archivos recientes' })" },
      { icon = icons.git.Repo,         key = "g", desc = "Estado de [G]it",            action = ":lua require('telescope.builtin').git_status()" },
      { icon = icons.ui.Pencil,        key = "d", desc = "[D]iario",                   action = ":lua require('telekasten').find_notes({ with_live_grep = true })" },
      { icon = icons.ui.Gear,          key = "a", desc = "[A]justes",                  action = ":e ~/.config/nix-neovim | :cd ~/.config/nix-neovim" },
      { icon = icons.ui.List,          key = 'p', desc = 'NixCats [p]awsible',         action = ":NixCats pawsible" },
      { icon = icons.ui.Exit,          key = "s", desc = "[S]alir",                    action = ":qa" },
    },
  },
  formats = {
    key = function(item)
      return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
    end,
    -- icon = { hl = pick_color() },
  },
  sections = {
    {
      text = {
        random_header_figlet(),
        hl = pick_color(),
        align = 'center',
      },
      random = os.time(),
      padding = 4,
    },
    {
      padding = 1,
      text = {
        "Vamos pues",
        hl = pick_color(),
        align = "center"
      },
      random = os.time(),
    },
    {
      icon = icons.ui.Keyboard,
      section = "keys",
      padding = 1,
    },
    {
      padding = 1,
      text = {
        "te luces lindo hoy",
        hl = pick_color(),
        align = "center"
      },
      random = os.time(),
    },
    function()
      local Snacks = require('snacks')
      local in_git = Snacks.git.get_root() ~= nil
      local cmds = {
        {
          -- title = "Colores de Git",
          icon = icons.ui.Branch,
          cmd = "source ~/.local/share/rstrz/.functions; ,colores-git-perl",
          height = 1,
          width = 100,
          align = "center",
        },
        {
          icon = icons.ui.Branch,
          title = "Estado de Git",
          cmd = "git --no-pager diff --stat -B -M -C",
          height = 10,
          width = 100,
          align = "center",
        },
      }
      return vim.tbl_map(function(cmd)
        return vim.tbl_extend("force", {
          section = "terminal",
          enabled = in_git,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        }, cmd)
      end, cmds)
    end,
  },
}
