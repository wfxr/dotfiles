local keymap = vim.keymap.set
local delmap = vim.keymap.del

-- Remove unwanted keymaps from lazyvim
delmap({ "n", "i" }, "<A-j>")
delmap({ "n", "i" }, "<A-k>")

-- stylua: ignore start
keymap("n", "<C-c>", "<cmd>q<cr>", { noremap = true })
keymap("n", "<C-x>", "<cmd>x<cr>", { noremap = true })

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
keymap('n', '<A-o>', '<c-w><c-p>', { noremap = true, desc = "Go to previous window" })

-- Extra readline-style keymaps
keymap('i', '<C-h>', '<BS>',    { noremap = true, desc = "Delete previous character" })
-- In insert mode, pressing Ctrl-O switches to normal mode for one command, then switches back to insert mode when the command is finished.
keymap('i', '<C-k>', '<C-o>D',   { noremap = true, desc = "Delete to start of line" })
keymap('i', '<C-u>', '<Esc>v0c', { noremap = true, desc = "Delete to start of line" })

keymap('n', '<A-w>', ':set wrap!<CR>', { noremap = true, desc = "Toggle wrap" })

-- nnoremap <leader>p :echo expand('<cword>')<CR>
keymap('n', '<leader>tr', '<cmd>execute ":!clitrans " .. expand("<cword>")<cr>', { noremap = true, desc = "Translate word" })

keymap('n', '<c-p>', '<c-]>', { noremap = false, desc = "Jump to tag" })

-- c-v to paste from clipboard
keymap({ "i", "c" }, "<c-v>", "<c-r>*", { noremap = true, desc = "Paste from clipboard" })

keymap('n', '<leader>l', ":.lua<cr>", { noremap = true, desc = "Run lua code" })
keymap('v', '<leader>l', ":lua<cr>",  { noremap = true, desc = "Run lua code" })
