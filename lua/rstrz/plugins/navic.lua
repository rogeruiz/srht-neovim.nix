local icons = require('rstrz.icons')

return {
  'nvim-navic',
  for_cat = 'general.always',
  on_require = {
    'nvim-navic',
    'lualine.nvim',
  },
  event = "DeferredUIEnter",
  after = function(plugin)
    require('nvim-navic').setup {
      highlight = true,
      icons = {
        Class = icons.kind.Class .. " ",
        Constant = icons.kind.Constant .. " ",
        Constructor = icons.kind.Constructor .. " ",
        Enum = icons.kind.Enum .. " ",
        EnumMember = icons.kind.EnumMember .. " ",
        Event = icons.kind.Event .. " ",
        Field = icons.kind.Field .. " ",
        File = icons.kind.File .. " ",
        Function = icons.kind.Function .. " ",
        Interface = icons.kind.Interface .. " ",
        Key = icons.kind.Key .. " ",
        Method = icons.kind.Method .. " ",
        Module = icons.kind.Module .. " ",
        Namespace = icons.kind.Namespace .. " ",
        Null = icons.type.Null .. " ",
        Operator = icons.kind.Operator .. " ",
        Package = icons.kind.Package .. " ",
        Property = icons.kind.Property .. " ",
        Struct = icons.kind.Struct .. " ",
        TypeParameter = icons.kind.TypeParameter .. " ",
        Variable = icons.kind.Variable .. " ",
        Array = icons.type.Array .. " ",
        Boolean = icons.type.Boolean .. " ",
        Number = icons.type.Number .. " ",
        Object = icons.type.Object .. " ",
        String = icons.type.String .. " ",
      },
      separator = " " .. icons.git.ui.untracked_thickest .. " ",
      -- limit for amount of context shown
      -- 0 means no limit
      depth = 0,
      -- indicator used when context hits depth limit
      depth_limit_indicator = icons.ui.HorizontalDots,
      safe_output = true,
    }
  end,
}
