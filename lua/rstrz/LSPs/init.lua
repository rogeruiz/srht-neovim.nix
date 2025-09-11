local catUtils = require('nixCatsUtils')
if (catUtils.isNixCats and nixCats('lspDebugMode')) then
  vim.lsp.set_log_level("debug")
end

local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = nil
if venv_path ~= nil then
  py_path = venv_path .. "/bin/python3"
else
  py_path = vim.g.python3_host_prog
end

-- NOTE: This file uses lzextras.lsp handler https://github.com/BirdeeHub/lzextras?tab=readme-ov-file#lsp-handler
-- This is a slightly more performant fallback function
-- for when you don't provide a filetype to trigger on yourself.
-- nixCats gives us the paths, which is faster than searching the rtp!
local old_ft_fallback = require('lze').h.lsp.get_ft_fallback()
require('lze').h.lsp.set_ft_fallback(function(name)
  local lspcfg = nixCats.pawsible({ "allPlugins", "opt", "nvim-lspconfig" }) or
      nixCats.pawsible({ "allPlugins", "start", "nvim-lspconfig" })
  if lspcfg then
    local ok, cfg = pcall(dofile, lspcfg .. "/lsp/" .. name .. ".lua")
    if not ok then
      ok, cfg = pcall(dofile, lspcfg .. "/lua/lspconfig/configs/" .. name .. ".lua")
    end
    return (ok and cfg or {}).filetypes or {}
  else
    return old_ft_fallback(name)
  end
end)
require('lze').load {
  {
    "nvim-lspconfig",
    for_cat = "general.core",
    on_require = { "lspconfig" },
    -- NOTE: define a function for lsp,
    -- and it will run for all specs with type(plugin.lsp) == table
    -- when their filetype trigger loads them
    lsp = function(plugin)
      vim.lsp.config(plugin.name, plugin.lsp or {})
      vim.lsp.enable(plugin.name)
    end,
    before = function(_)
      vim.lsp.config('*', {
        -- capabilities = require('blink.cmp').get_lsp_capabilities(),
        on_attach = require('rstrz.LSPs.on_attach'),
      })
    end,
  },
  {
    "mason.nvim",
    -- only run it when not on nix
    enabled = not catUtils.isNixCats,
    on_plugin = { "nvim-lspconfig" },
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("mason-lspconfig.nvim")
      require('mason').setup()
      -- auto install will make it install servers when lspconfig is called on them.
      require('mason-lspconfig').setup { automatic_installation = true, }
    end,
  },
  {
    -- lazydev makes your lsp way better in your config without needing extra lsp configuration.
    "lazydev.nvim",
    for_cat = "neonixdev",
    cmd = { "LazyDev" },
    ft = "lua",
    after = function(_)
      require('lazydev').setup({
        library = {
          { words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. '/lua' },
        },
      })
    end,
  },
  {
    -- name of the lsp
    "lua_ls",
    enabled = nixCats('lua') or nixCats('neonixdev') or false,
    -- provide a table containing filetypes,
    -- and then whatever your functions defined in the function type specs expect.
    -- in our case, it just expects the normal lspconfig setup options,
    -- but with a default on_attach and capabilities
    lsp = {
      -- if you provide the filetypes it doesn't ask lspconfig for the filetypes
      filetypes = { 'lua' },
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          formatters = {
            ignoreComments = true,
          },
          signatureHelp = { enabled = true },
          diagnostics = {
            globals = { "nixCats", "vim", },
            disable = { 'missing-fields' },
          },
          telemetry = { enabled = false },
        },
      },
    },
    -- also these are regular specs and you can use before and after and all the other normal fields
  },
  {
    "gopls",
    for_cat = "go",
    -- if you don't provide the filetypes it asks lspconfig for them
    lsp = {
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
    },
  },
  {
    'pylsp',
    for_cat = 'python',
    lsp = {
      filetypes = { 'python' },
      settings = {
        pylsp = {
          plugins = {
            -- formatter options
            black = { enabled = false },
            autopep8 = { enabled = false },
            yapf = { enabled = false },
            -- linter options
            pylint = { enabled = false },
            pyflakes = { enabled = false },
            pycodestyle = { enabled = false },
            -- type checker
            pylsp_mypy = {
              enabled = true,
              overrides = { "--python-executable", py_path, true },
              report_progress = true,
              live_mode = false,
            },
            ruff = {
              enabled = true,
            },
            -- auto-completion options
            jedi_completion = { fuzzy = true },
            -- import sorting
            pyls_isort = { enabled = true },
          },
        },
      },
    },
  },
  {
    "typescript-tools.nvim",
    for_cat = "ui-work",
    ft = {
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptriptreact",
    },
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd('plenary.nvim')
      vim.cmd.packadd('nvim-lspconfig')
    end,
    after = function(_)
      require('typescript-tools').setup {
        settings = {},
      }
    end
  },
  {
    "rustaceanvim",
    for_cat = "rust",
    lazy = false,
    before = function()
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          -- on_attach = function(client, bufnr) end,
          default_settings = {
            ['rust-analyzer'] = {
              files = {
                exclude = {
                  "_build",
                  ".dart_tool",
                  ".flatpak-builder",
                  ".git",
                  ".gitlab",
                  ".gitlab-ci",
                  ".gradle",
                  ".idea",
                  ".next",
                  ".project",
                  ".scannerwork",
                  ".settings",
                  ".venv",
                  ".direnv",
                  "archetype-resources",
                  "bin",
                  "hooks",
                  "node_modules",
                  "po",
                  "screenshots",
                  "target"
                }
              },
            },
          },
        },
      }
    end,
    load = function(name)
      vim.cmd.packadd(name)
    end,
  },
  {
    'emmet_language_server',
    for_cat = 'ui-work',
    lsp = {
      filetypes = {
        "astro",
        "css",
        "eruby",
        "html",
        "htmlangular",
        "htmldjango",
        "javascriptreact",
        "less",
        "pug",
        "sass",
        "scss",
        "svelte",
        "templ",
        "typescriptreact",
        "vue"
      },
    },
  },
  {
    'tailwindcss',
    for_cat = 'ui-work',
    lsp = {
      filetypes = {
        "aspnetcorerazor",
        "astro",
        "astro-markdown",
        "blade",
        "clojure",
        "django-html",
        "htmldjango",
        "edge",
        "eelixir",
        "elixir",
        "ejs",
        "erb",
        "eruby",
        "gohtml",
        "gohtmltmpl",
        "haml",
        "handlebars",
        "hbs",
        "html",
        "htmlangular",
        "html-eex",
        "heex",
        "jade",
        "leaf",
        "liquid",
        "markdown",
        "mdx",
        "mustache",
        "njk",
        "nunjucks",
        "php",
        "razor",
        "slim",
        "twig",
        "css",
        "less",
        "postcss",
        "sass",
        "scss",
        "stylus",
        "sugarss",
        "javascript",
        "javascriptreact",
        "reason",
        "rescript",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "templ"
      },
      settings = {
        tailwindCSS = {
          classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
          includeLanguages = {
            eelixir = "html-eex",
            elixir = "phoenix-heex",
            eruby = "erb",
            heex = "phoenix-heex",
            htmlangular = "html",
            templ = "html"
          },
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning"
          },
          validate = true
        }
      },
    },

  },
  -- {
  --   "powershell-nvim",
  --   for_cat = "pwsh",
  --   lsp = {
  --     filetypes = { "ps1" },
  --     settings = {
  --     },
  --
  --     on_attach = function(client, bufnr)
  --       -- Enable completion triggered by <c-x><c-o>
  --       vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
  --
  --       -- local bufopts = { noremap = true, silent = true, buffer = bufnr }
  --       -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  --       -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  --       -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  --       -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  --       -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  --       -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  --       -- vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  --       -- vim.keymap.set('n', '<Leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  --       -- vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  --       -- vim.keymap.set('n', '<Leader>td', vim.lsp.buf.type_definition, bufopts)
  --     end,
  --   },
  --   load = function(name)
  --     vim.cmd.packadd(name)
  --   end,
  --   after = function(plugin)
  --     require('powershell').setup({
  --       bundle_path = vim.env.POWERSHELL_EDITOR_SERVICES_BUNDLE_PATH,
  --     })
  --   end,
  -- },
  {
    "nil_ls",
    -- mason doesn't have nixd
    enabled = not catUtils.isNixCats,
    lsp = {
      filetypes = { "nix" },
    },
  },
  {
    "nixd",
    enabled = catUtils.isNixCats and (nixCats('nix') or nixCats('neonixdev')) or false,
    lsp = {
      filetypes = { "nix" },
      settings = {
        nixd = {
          -- nixd requires some configuration.
          -- luckily, the nixCats plugin is here to pass whatever we need!
          -- we passed this in via the `extra` table in our packageDefinitions
          -- for additional configuration options, refer to:
          -- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
          nixpkgs = {
            -- in the extras set of your package definition:
            -- nixdExtras.nixpkgs = ''import ${pkgs.path} {}''
            expr = nixCats.extra("nixdExtras.nixpkgs") or [[import <nixpkgs> {}]],
          },
          options = {
            -- If you integrated with your system flake,
            -- you should use inputs.self as the path to your system flake
            -- that way it will ALWAYS work, regardless
            -- of where your config actually was.
            nixos = {
              -- nixdExtras.nixos_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.configname.options''
              expr = nixCats.extra("nixdExtras.nixos_options")
            },
            -- If you have your config as a separate flake, inputs.self would be referring to the wrong flake.
            -- You can override the correct one into your package definition on import in your main configuration,
            -- or just put an absolute path to where it usually is and accept the impurity.
            ["home-manager"] = {
              -- nixdExtras.home_manager_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").homeConfigurations.configname.options''
              expr = nixCats.extra("nixdExtras.home_manager_options")
            }
          },
          formatting = {
            command = { "nixfmt" }
          },
          diagnostic = {
            suppress = {
              "sema-escaping-with"
            }
          }
        }
      },
    },
  },
}
