vim.cmd([[
  au FileType markdown setlocal shiftwidth=4 tabstop=4 wrap spell expandtab tw=80 wm=0 linebreak list
  au FileType yaml setlocal shiftwidth=2 tabstop=2 nowrap spell expandtab tw=80 wm=0 linebreak list
  au FileType toml setlocal shiftwidth=2 tabstop=2 nowrap spell expandtab tw=80 wm=0 linebreak list
  au FileType gitcommit setlocal shiftwidth=4 tabstop=4 expandtab wrap spell tw=80 wm=0 linebreak list
  au FileType dbui setlocal shiftwidth=2 tabstop=2 expandtab wrap
]])

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = {
    '*.webc',
  },
  command = "set ft=html",
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = {
    '*.jshintrc',
    '*.bowerrc',
    '*.pantheonrc',
    '*.eslintrc',
  },
  command = "set ft=json",
})

vim.cmd([[
  au BufRead,BufNewFile *.applescript set ft=applescript
  au BufNewFile,BufRead *.php set ft=php.html.js.css
  au BufNewFile,BufRead *.blade.php set ft=blade.html.php
  au BufNewFile,BufRead *.ejs set ft=liquid.html.js.css
  au BufNewFile,BufRead *.twig set ft=html.twig
  au BufNewFile,BufRead *.hbs set ft=html
  au BufNewFile,BufRead *.toml set ft=toml
  au BufNewFile,BufRead nginx.config set ft=nginx
  au BufRead,BufNewFile spec set ft=yaml
  au BufNewFile,BufRead *.ledger set ft=ledger
  au BufNewFile,BufRead .env* set ft=sh
  au BufNewFile,BufRead Brewfile set ft=ruby
  au BufNewFile,BufRead sketchybarrc set ft=sh
  au BufRead,BufNewFile todo.txt set ft=todotxt
  au BufRead,BufNewFile *.todo set ft=todotxt
]])
