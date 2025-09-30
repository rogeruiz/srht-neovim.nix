return {
  {
    'tiny-glimmer-nvim',
    for_cat = "general.anime",
    event = "UIEnter",
    lazy = false,
    after = function()
      require('tiny-glimmer').setup({
        enabled = true,
        overwrite = {
          yank = {
            enable = true,
            default_animation = "rainbow",
          },
          search = {
            enabled = true,
            default_animation = "pulse",
            next_mapping = "n",
            prev_mapping = "N",
          },
          paste = {
            enabled = true,
            default_animation = "reverse_fade",

            -- Keys to paste
            paste_mapping = "p",

            -- Keys to paste above the cursor
            Paste_mapping = "P",
          },
          undo = {
            enabled = true,

            default_animation = {
              name = "fade",

              settings = {
                from_color = "DiffDelete",

                max_duration = 500,
                min_duration = 500,
              },
            },
            undo_mapping = "u",
          },
          redo = {
            enabled = true,

            default_animation = {
              name = "fade",

              settings = {
                from_color = "DiffAdd",

                max_duration = 500,
                min_duration = 500,
              },
            },

            redo_mapping = "<c-r>",
          },
        },
      })
    end
  },
}
