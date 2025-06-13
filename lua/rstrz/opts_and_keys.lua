-- NOTE: These 2 need to be set up before any plugins are loaded.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  nbsp = '␣',
  tab = '›·',
  trail = '·',
  eol = '¬',
  extends = '›',
  precedes = '‹',
}

vim.o.termguicolors = true;
vim.o.background = "light"

-- Set highlight on search
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Indent
-- vim.o.smarttab = true
vim.opt.cpoptions:append('I')
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.whichwrap = "<,>,h,l"
-- vim.o.autoindent = true
-- vim.o.tabstop = 4
-- vim.o.softtabstop = 4
-- vim.o.shiftwidth = 4

-- Haga que lavim.o.neuvas búfer aparescan abajo o a la derecha
vim.o.splitbelow = true
vim.o.splitright = true

-- Fold method
vim.o.foldmethod = "expr"
vim.o.foldlevel = 6
vim.o.spelllang = "en,es"

-- stops line wrapping from being confusing
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = false

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
vim.wo.relativenumber = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.colorcolumn = "50,72,80,100"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,preview,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Disable auto comment on enter ]]
-- See :help formatoptions
vim.api.nvim_create_autocmd("FileType", {
  desc = "remove formatoptions",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Mover linea hacia abajo' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Mover linea hacia arriba' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Desplazar hacia abajo' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Desplazar hacia arriba' })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Siguiente Resultado de Búsqueda' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Anterior Resultado de Búsqueda' })

vim.keymap.set("n", "<leader><leader>[", "<cmd>bprev<CR>", { desc = 'Búfer Anterior' })
vim.keymap.set("n", "<leader><leader>]", "<cmd>bnext<CR>", { desc = 'Búfer Siguiente' })
vim.keymap.set("n", "<leader><leader>l", "<cmd>b#<CR>", { desc = 'Ultimo búfer' })
vim.keymap.set("n", "<leader><leader>d", "<cmd>bdelete<CR>", { desc = 'Borrar búfer' })

-- see help sticky keys on windows
vim.cmd([[command! W w]])
vim.cmd([[command! Wq wq]])
vim.cmd([[command! WQ wq]])
vim.cmd([[command! Q q]])

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Ir al anterior mensaje de diagnóstico' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Ir al siguiente message de diagnóstico' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Abrir mensaje diagnóstico flotante' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Abrir lista de diagnóstico' })


vim.o.clipboard = 'unnamed'

-- You shou instead use these keybindings so that they are still easy to use, but dont conflict
vim.keymap.set({ "v", "x", "n" }, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank al portapapeles' })
vim.keymap.set({ "n", "v", "x" }, '<leader>Y', '"+yy',
  { noremap = true, silent = true, desc = 'Yank linea al portapapeles' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p',
  { noremap = true, silent = true, desc = 'Pegar desde el portapapeles' })
vim.keymap.set('i', '<C-p>', '<C-r><C-p>+',
  { noremap = true, silent = true, desc = 'Pegar desde el portapapeles desde el modo de inserción' })
vim.keymap.set("x", "<leader>P", '"_dP',
  { noremap = true, silent = true, desc = 'Pegar sobre la selección sin borrar el registro sin nombre' })

vim.keymap.set({ "n", "v" }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize +2<CR>', { noremap = true, silent = true })
-- Keymaps para aumentar la indentacíon
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })
