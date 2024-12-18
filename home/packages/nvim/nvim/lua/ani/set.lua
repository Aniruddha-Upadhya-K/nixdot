-- vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.g.mapleader = " "

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
vim.opt.foldtext = ""

-- vim.keymap.set('n', '[[', '?{', {})
-- vim.keymap.set('n', '][', '/}<CR>b99]}', {})
-- vim.keymap.set('n', ']]', 'j0[[%/{<CR>', {})
-- vim.keymap.set('n', '[]', 'k$][%?}<CR>', {})
