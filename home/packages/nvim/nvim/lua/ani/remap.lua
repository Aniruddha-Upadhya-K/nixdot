-- Set leader key to space
vim.g.mapleader = " "

-- Open file explorer (netrw) with <leader>pv
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected lines up or down in visual mode and re-indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")  -- Move selected lines down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")  -- Move selected lines upper

-- Keep cursor in the middle of the screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- Scroll down
vim.keymap.set("n", "<C-u>", "<C-u>zz")  -- Scroll up

-- Center cursor after searching
vim.keymap.set("n", "n", "nzzzv")  -- Next search result
vim.keymap.set("n", "N", "Nzzzv")  -- Previous search result

-- Restart LSP server with <leader>zig
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Paste over currently selected text without yanking it
vim.keymap.set("x", "<leader>dp", [["_dP]])

-- Paste from clipboard before cursor
vim.keymap.set("n", "<leader>p", [["+p]])

-- Paste from clipboard after cursor
vim.keymap.set("n", "<leader>P", [["+P]])

-- Copy and paste selected text above the selected text
vim.keymap.set({"n", "v"}, "<leader>kp", "yO<Esc>p")

-- Yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete text without yanking it
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Select all text
vim.keymap.set("n", "<leader>a", "gg<S-v>G")

-- Exit insert mode with jk
vim.keymap.set("i", "jk", "<Esc>")

-- Find and replace all occurrences of the word under the cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Edit Neovim configuration file with <leader>vpp
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/ani/lazy_init.lua<CR>")

-- Source the Neovim configuration file with <leader><leader>
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so ~/.config/nvim/init.lua")
end)

-- Add parenthesis around selected text
vim.keymap.set("v", "<leader>(", 'c(<C-r><C-o>")<ESC>')
vim.keymap.set("v", "<leader>{", 'c{<C-r><C-o>"}<ESC>')
vim.keymap.set("v", "<leader><", 'c<<C-r><C-o>"><ESC>')
vim.keymap.set("v", "<leader>[", 'c[<C-r><C-o>"]<ESC>')

-- Navigate vim panes
