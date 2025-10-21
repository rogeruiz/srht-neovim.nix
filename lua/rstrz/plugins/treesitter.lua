-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
return {
  {
    "nvim-treesitter",
    for_cat = 'general.treesitter',
    -- cmd = { "" },
    event = "DeferredUIEnter",
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    load = function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("nvim-treesitter-textobjects")
    end,
    after = function(plugin)
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      -- Set a writable directory for parser installation to avoid Nix store permission issues
      local parser_dir = vim.fn.stdpath('data') .. '/treesitter-parsers'
      vim.opt.runtimepath:prepend(parser_dir)

      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.structurizr = {
        install_info = {
          url = "~/Developer/oss/rogeruiz/srht/tree-sitter-structurizr-dsl",
          files = { "src/parser.c" },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "structurizr",
      }

      require('nvim-treesitter.configs').setup {
        parser_install_dir = parser_dir,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = { enable = false, },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },
}
