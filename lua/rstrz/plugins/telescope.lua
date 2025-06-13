-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!
--
-- The easiest way to use telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of help_tags options and
-- a corresponding preview of the help.
--
-- Two important keymaps to use while in telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("No es un repositorio de git. Buscando en la carpeta de trabajo actual")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = { git_root },
      prompt_title = 'Buscando adentro de la raiz de Git',
    })
  end
end

return {
  {
    "telescope.nvim",
    for_cat = 'general.telescope',
    cmd = { "Telescope", "LiveGrepGitRoot" },
    -- NOTE: our on attach function defines keybinds that call telescope.
    -- so, the on_require handler will load telescope when we use those.
    on_require = { "telescope", },
    -- event = "",
    -- ft = "",
    keys = {
      { "<leader>bM", '<cmd>Telescope notify<CR>', mode = { "n" }, desc = '[Buscar [M]ensajes' },
      { "<leader>bp", live_grep_git_root,          mode = { "n" }, desc = '[B]uscar raiz del [p]royecto git', },
      {
        "<leader>/",
        function()
          -- Slightly advanced example of overriding default behavior and theme
          -- You can pass additional configuration to telescope to change theme, layout, etc.
          return require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_cursor {
            previewer = false,
            prompt_title = 'Busque con fzf en este archivo',
          })
        end,
        mode = { "n" },
        desc = '[/] Buscar difuso en el bufér actual',
      },
      {
        "<leader>b/",
        function()
          return require('telescope.builtin').live_grep {
            grep_open_files = true,
            prompt_title = 'Busque con Grep en los Archivos Abiertos',
          }
        end,
        mode = { "n" },
        desc = '[B]uscar en [/] Archivos Abiertos'
      },
      {
        "<leader><leader>b",
        function()
          return require('telescope.builtin').buffers {
            prompt_title = 'Búfers',
          }
        end,
        mode = { "n" },
        desc = '[ ] Buscar buférs abiertos',
      },
      {
        "<leader>b.",
        function()
          return require('telescope.builtin').oldfiles {
            prompt_title = 'Archivos recientes',
          }
        end,
        mode = { "n" },
        desc = '[B]uscar Archivos Recientes ("." para repetir)',
      },
      {
        "<leader>br",
        function()
          return require('telescope.builtin').resume {
            prompt_title = 'Reanudar de archivos',
          }
        end,
        mode = { "n" },
        desc = '[B]uscar [R]eanudar',
      },
      {
        "<leader>d",
        function()
          return require('telescope.builtin').diagnostics {
            prompt_title = 'Diagnósticos',
          }
        end,
        mode = { "n" },
        desc =
        '[B]uscar [D]iagnósticos',
      },
      {
        "<leader>bg",
        function()
          return require('telescope.builtin').live_grep {
            prompt_title = 'Usando rg para encontrar archivos',
          }
        end,
        mode = { "n" },
        desc =
        '[B]uscar con [G]rep',
      },
      {
        "<leader>bP",
        function()
          return require('telescope.builtin').grep_string(require('telescope.themes').get_cursor({
            width = { padding = 0.8 },
            height = { padding = 0.8 },
            prompt_title = "Buscando en archivos que compartin una palabra",
            preview_cutoff = 80,
          }))
        end,
        mode = { "n" },
        desc = '[B]uscar [P]alabra actual',
      },
      {
        "<leader>bt",
        function()
          return require('telescope.builtin').builtin {
            prompt_title = 'Opciones de Telescope',
          }
        end,
        mode = { "n" },
        desc = '[B]uscar Select [T]elescope',
      },
      {
        "<leader>ba",
        function()
          return require('telescope.builtin').find_files {
            hidden = true,
            prompt_title = 'Buscando archivos',
          }
        end,
        mode = { "n" },
        desc = '[B]uscar [A]rchivos',
      },
      {
        "<leader>bk",
        function()
          return require('telescope.builtin').keymaps {
            prompt_title = 'Buscando atajos de teclado',
          }
        end,
        mode = { "n" },
        desc = '[B]uscar atajos de teclado ([K]eymaps)',
      },
      {
        "<leader>bs",
        function()
          return require('telescope.builtin').help_tags {
            prompt_title = 'Soccoro',
          }
        end,
        mode = { "n" },
        desc = '[B]uscar [S]occoro',
      },
    },
    -- colorscheme = "",
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("telescope-fzf-native.nvim")
      vim.cmd.packadd("telescope-ui-select.nvim")
    end,
    after = function(plugin)
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            i = {
              ['<c-enter>'] = 'to_fuzzy_refine',
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
          theme = "ivy",
          path_display = {
            truncate = 3,
          },
          layout_strategy = 'center',
          layout_config = {
            width = 0.7,
            preview_cutoff = 40,
            height = 0.3,
          },
          file_ignore_patterns = {
            "^.git/"
          },
        },
        -- pickers = {}
        extensions = {
          fzf = {},
          ['ui-select'] = {
            require('telescope.themes').get_ivy(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
    end,
  },
}
