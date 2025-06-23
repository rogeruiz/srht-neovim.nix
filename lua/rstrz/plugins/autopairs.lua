---@module 'custom.plugins.autopairs'
---@author 'Roger Steve Ruiz'
---@license 'MIT'

return {
  "nvim-autopairs",
  for_cat = 'general.extra',
  event = 'DeferredUIEnter',
  after = function()
    local npairs = require("nvim-autopairs")
    -- local Rule = require('nvim-autopairs.rule')

    -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

    npairs.setup({
      disable_filetype = {
        "TelescopePrompt",
        "vim",
      },
      map_cr = true,
      check_ts = true,
      ts_config = {
        javascript = {
          'template_string',
        },
      },
    })

    -- README: Para usar condiciones particulares mientras usando Tree-Sitter
    -- pa' las reglas de `npairs`.
    -- local ts_conds = require('nvim-autopairs.ts-conds')
    -- -- press % => %% only while inside a comment or string
    -- npairs.add_rules({
    --   Rule("%", "%", "lua")
    --       :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
    --   Rule("$", "$", "lua")
    --       :with_pair(ts_conds.is_not_ts_node({ 'function' }))
    -- })
  end
}
