return {
    "gitsigns.nvim",
    for_cat = 'general.always',
    event = "DeferredUIEnter",
    -- cmd = { "" },
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    after = function(plugin)
      local ui = require('rstrz.icons').git.ui
      require('gitsigns').setup({
        signs                        = {
          add          = { text = ui.add_thickest, },
          change       = { text = ui.change_thickest, },
          delete       = { text = ui.delete_thickest, },
          topdelete    = { text = ui.topdelete_thickest, },
          changedelete = { text = ui.changedelete_thickest, },
          untracked    = { text = ui.untracked_thickest, },
        },
        signs_staged                 = {
          add          = { text = ui.add_thickest, },
          change       = { text = ui.change_thickest, },
          delete       = { text = ui.delete_thickest, },
          topdelete    = { text = ui.topdelete_thickest, },
          changedelete = { text = ui.changedelete_thickest, },
        },
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = true,  -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = true,  -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          interval = 1000,
          follow_files = true,
        },
        auto_attach                  = true,
        attach_to_untracked          = true,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text          = true,
          virt_text_pos      = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay              = 1000,
          ignore_whitespace  = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = ' <author>, <author_time:%R> 󰍩 <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil, -- Use default
        max_file_length              = 40000,
        preview_config               = {
          -- Options passed to nvim_open_win
          border   = "single",
          style    = "minimal",
          relative = "cursor",
          row      = 0,
          col      = 1,
        },

        on_attach                    = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map({ 'n', 'v' }, ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Brinca al proximo hunk' })

          map({ 'n', 'v' }, '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, desc = 'Brinca al hunk anterior' })

          -- Actions
          -- visual mode
          map('v', '<leader>hs', function()
            gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'stage git hunk' })
          map('v', '<leader>hr', function()
            gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = 'reset git hunk' })
          -- normal mode
          map('n', '<leader>gs', gs.stage_hunk, { desc = 'git hunk en el escenario' })
          map('n', '<leader>gr', gs.reset_hunk, { desc = 'git hunk reiniciado' })
          map('n', '<leader>gS', gs.stage_buffer, { desc = 'git búfer en el escenario' })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'deshacer hunk en el escenario' })
          map('n', '<leader>gR', gs.reset_buffer, { desc = 'git búfer reiniciado' })
          map('n', '<leader>gp', gs.preview_hunk, { desc = 'vista previa del git hunk' })
          map('n', '<leader>gb', function()
            gs.blame_line { full = false }
          end, { desc = 'git culpa de la línea' })
          map('n', '<leader>gd', gs.diffthis, { desc = 'git diff against index' })
          map('n', '<leader>gD', function()
            gs.diffthis '~'
          end, { desc = 'git diferencia desde el ultimo compromiso' })

          -- Toggles
          map('n', '<leader>gtb', gs.toggle_current_line_blame, { desc = 'alternar la culpa de línea git' })
          map('n', '<leader>gtd', gs.toggle_deleted, { desc = 'alternar mostrar borrados git' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'selecionar git hunk' })
        end,
      })
      vim.cmd([[hi GitSignsAdd guifg=#04de21]])
      vim.cmd([[hi GitSignsChange guifg=#83fce6]])
      vim.cmd([[hi GitSignsDelete guifg=#fa2525]])
    end,
  }
