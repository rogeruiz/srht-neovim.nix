local _border = "double"

local function bordered_hover(_opts)
        _opts = _opts or {}
        return vim.lsp.buf.hover(vim.tbl_deep_extend("force", _opts, {
                border = _border
        }))
end

local function bordered_signature_help(_opts)
        _opts = _opts or {}
        return vim.lsp.buf.signature_help(vim.tbl_deep_extend("force", _opts, {
                border = _border
        }))
end

return function(client, bufnr)
  -- we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.

  -- Navic no sirve en ciertos LSPs. Los eliminamos con `~=` y `(exp and exp)`.
  if (client.name ~= 'tailwindcss' and
        client.name ~= 'emmet_language_server') then
    require('nvim-navic').attach(client, bufnr)
  end

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ombra')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ódigo [A]cción')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')

  -- NOTE: why are these functions that call the telescope builtin?
  -- because otherwise they would load telescope eagerly when this is defined.
  -- due to us using the on_require handler to make sure it is available.
  if nixCats('general.telescope') then
    nmap('gr', function() require('telescope.builtin').lsp_references() end, '[G]oto [R]eferencias')
    nmap('gI', function() require('telescope.builtin').lsp_implementations() end, '[G]oto [I]mplementación')
    nmap('<leader>ds', function() require('telescope.builtin').lsp_document_symbols() end, '[S]imbolos del [d]ocumento')
    nmap('<leader>ws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
      '[W]orkspace [S]imbolos')
  end -- TODO: someone who knows the builtin versions of these to do instead help me out please.

  nmap('<leader>D', vim.lsp.buf.type_definition, 'Tipo [D]efinación')

  -- See `:help K` for why this keymap
  nmap('K', bordered_hover, 'Documentación para el hover')
  nmap('<C-k>', bordered_signature_help, 'Documentación de la Firma')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaración')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]ñadir Carpeta')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace Borra[r] Carpeta')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ista de Carpetas')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Formatear el búfer actual con LSP' })
end
