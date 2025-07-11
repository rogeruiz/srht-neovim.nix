local load_w_after = function(name)
  vim.cmd.packadd(name)
  vim.cmd.packadd(name .. '/after')
end

return {
  {
    "cmp-cmdline",
    for_cat = "general.blink",
    on_plugin = { "blink.cmp" },
    load = load_w_after,
  },
  {
    "blink.compat",
    for_cat = "general.blink",
    dep_of = { "cmp-cmdline" },
  },
  {
    "luasnip",
    for_cat = "general.blink",
    dep_of = { "blink.cmp" },
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd('blink-emoji')
      vim.cmd.packadd('blink-nerdfont')
      vim.cmd.packadd('blink-gitmoji')
      vim.cmd.packadd('blink-conventional-commits')
      vim.cmd.packadd('blink-env')
      vim.cmd.packadd('blink-git')
      vim.cmd.packadd('friendly-snippets')
    end,
    after = function(_)
      for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/rstrz/snippets/*.lua", true)) do
        loadfile(ft_path)()
      end

      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      local ls = require('luasnip')

      vim.keymap.set({ "i", "s" }, "<M-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end,
  },
  {
    "colorful-menu",
    for_cat = "general.blink",
    on_plugin = { "blink.cmp" },
    after = function(_)
      require('colorful-menu').setup({});
    end,
  },
  {
    "blink.cmp",
    for_cat = "general.blink",
    event = "DeferredUIEnter",
    on_require = { "lspconfig" },
    after = function(_)
      require("blink.cmp").setup({
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- See :h blink-cmp-config-keymap for configuring keymaps
        keymap = {
          preset = 'default',
        },
        cmdline = {
          enabled = true,
          completion = {
            menu = {
              auto_show = true,
            },
          },
          sources = function()
            local type = vim.fn.getcmdtype()
            -- Search forward and backward
            if type == '/' or type == '?' then return { 'buffer' } end
            -- Commands
            if type == ':' or type == '@' then return { 'cmdline', 'cmp_cmdline' } end
            return { 'lsp', 'path', 'snippets', 'buffer', 'luasnip', 'dadbod' }
          end,
        },
        fuzzy = {
          sorts = {
            'exact',
            -- defaults
            'score',
            'sort_text',
          },
        },
        signature = {
          enabled = true,
          window = {
            show_documentation = true,
          },
        },
        completion = {
          menu = {
            draw = {
              treesitter = { 'lsp' },
              columns = {
                { 'kind_icon', gap = 1, },
                { 'label',     'kind',  gap = 2, },
              },
              components = {
                label = {
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
          },
        },
        snippets = {
          preset = 'luasnip',
        },
        sources = {
          default = {
            'lsp',
            'path',
            'snippets',
            'buffer',
            'omni',
            'git',
            'conventional_commits',
            'gitmoji',
            'emoji',
            'nerdfont',
          },
          providers = {
            git = {
              module = 'blink-cmp-git',
              name = 'Git',
              opts = {},
            },
            conventional_commits = {
              name = 'Conventional Commits',
              module = 'blink-cmp-conventional-commits',
              enabled = function()
                return vim.bo.filetype == 'gitcommit'
              end,
            },
            gitmoji = {
              name = 'gitmoji',
              module = 'gitmoji.blink',
              score_offset = 25,
              opts = {
                filetypes = {
                  'gitcommit',
                }
              },
            },
            emoji = {
              module = 'blink-emoji',
              name = 'Emoji',
              score_offset = 20,
              opts = {
                insert = true,
                trigger = function()
                  return { ":" }
                end,
              },
              should_show_items = function()
                return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
              end
            },
            nerdfont = {
              module = 'blink-nerdfont',
              name = 'Nerd Fonts',
              score_offset = 5,
              opts = { insert = true },
            },
            path = {
              score_offset = 50,
            },
            lsp = {
              score_offset = 40,
            },
            snippets = {
              score_offset = 40,
            },
            cmp_cmdline = {
              name = 'cmp_cmdline',
              module = 'blink.compat.source',
              score_offset = -100,
              opts = {
                cmp_name = 'cmdline',
              },
            },
            dadbod = {
              name = 'Dadbod',
              module = 'vim_dadbod_completion.blink',
            },
          },
        },
      })
    end,
  },
}
