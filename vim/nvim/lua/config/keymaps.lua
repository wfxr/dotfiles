-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local keymap = vim.keymap.set
local mapdel = vim.keymap.del

-- mapdel({ "n", "t" }, "<c-h>")
-- mapdel({ "n", "t" }, "<c-l>")
-- mapdel({ "n", "t" }, "<c-j>")
-- mapdel({ "n", "t" }, "<c-k>")

keymap("n", "<C-c>", "<cmd>q<cr>", { noremap = true })
keymap("n", "<C-x>", "<cmd>x<cr>", { noremap = true })

-- floating terminal
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end

-- stylua: ignore start
keymap("n", "<c-\\>", lazyterm, { desc = "Terminal (root dir)" })
keymap("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

keymap("n", "<c-/>", "gccj", { remap = true, desc = "Comment line" })
keymap("v", "<c-/>", "gcj",  { remap = true, desc = "Comment line" })
keymap("n", "<c-_>", "gccj", { remap = true, desc = "which_key_ignore" })
keymap("v", "<c-_>", "gcj",  { remap = true, desc = "which_key_ignore" })

keymap('n', 'zj', 'o<Esc>k',  { noremap = true, desc = "Insert line below" })
keymap('n', 'zk', 'O<Esc>j',  { noremap = true, desc = "Insert line above" })
keymap('n', 'zl', 'i <Esc>l', { noremap = true, desc = "Insert space after" })

keymap('n', 'gp', '`[v`]', { noremap = true, silent = true, desc = "Select last paste" })
keymap('x', 'p',  'pgvy',  { noremap = true, silent = true, desc = "Paste multiple times" })

-- Quickly move in normal mode
keymap('n', '<c-j>', '<c-y>', { noremap = true, desc = "Scroll up" })
keymap('n', '<c-k>', '<c-e>', { noremap = true, desc = "Scroll down" })
keymap('n', '<c-e>', 'A',     { noremap = true, desc = "Append at end of line" })
keymap('n', '<c-a>', 'I',     { noremap = true, desc = "Insert at start of line" })

-- Move between windows quickly
keymap('n', '<A-h>', '<C-w>h', { noremap = true, desc = "Move to left window" })
keymap('n', '<A-j>', '<C-w>j', { noremap = true, desc = "Move to bottom window" })
keymap('n', '<A-k>', '<C-w>k', { noremap = true, desc = "Move to top window" })
keymap('n', '<A-l>', '<C-w>l', { noremap = true, desc = "Move to right window" })

-- Extra readline-style keymaps
keymap('i', '<C-a>',  '<Home>',  { noremap = true, desc = "Move to start of line" })
keymap('i', '<C-e>',  '<End>',   { noremap = true, desc = "Move to end of line" })
keymap('i', '<C-h>', '<BS>',    { noremap = true, desc = "Delete previous character" })
keymap('i', '<C-d>', '<Del>',   { noremap = true, desc = "Delete next character" })
keymap('i', '<C-f>', '<Right>', { noremap = true, desc = "Move right" })
keymap('i', '<C-b>', '<Left>',  { noremap = true, desc = "Move left" })
-- In insert mode, pressing Ctrl-O switches to normal mode for one command, then switches back to insert mode when the command is finished.
keymap('i', '<C-k>', '<C-o>D',   { noremap = true, desc = "Delete to start of line" })
keymap('i', '<C-u>', '<Esc>v0c', { noremap = true, desc = "Delete to start of line" })

keymap('n', '<A-w>', ':set wrap!<CR>', { noremap = true, desc = "Toggle wrap" })

-- nnoremap <leader>p :echo expand('<cword>')<CR>
keymap('n', '<leader>tr', '<cmd>execute ":!clitrans " .. expand("<cword>")<cr>', { noremap = true, desc = "Translate word" })

keymap('n', '<c-p>', '<c-]>', { noremap = false, desc = "Jump to tag" })

-- c-v to paste from clipboard
keymap({ "i", "c" }, "<c-v>", "<c-r>*", { noremap = true, desc = "Paste from clipboard" })
