return {
  'nvim-ufo',
  for_cat = 'general.extra',
  load = function(name)
    vim.cmd.packadd(name)
    vim.cmd.packadd('promise-async')
  end,
  after = function()
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Usando este mapa de valores pa' cambiar lo que usa
    local ftMap = {
      snacks_dashboard = '',
      toggle_term = '',
      oil = '',
    }
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        if ftMap[filetype] ~= nil then
          return ftMap[filetype]
        end

        return { 'treesitter', 'indent' }
      end
    })
  end
}
