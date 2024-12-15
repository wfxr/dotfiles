-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt

if vim.fn.has("nvim-0.8") == 1 then
  opt.backup = true
  opt.cmdheight = 0
  opt.backupdir = vim.fn.stdpath("state") .. "/backup"
end

if vim.g.neovide then
  vim.o.guifont = "Fira Code,Symbols Nerd Font Mono:h34"
  vim.g.neovide_scale_factor = 0.3
end

opt.swapfile = false
opt.mousescroll = "ver:2,hor:6"

-- vim.g.node_host_prog = "/Users/folke/.pnpm-global/5/node_modules/neovim/bin/cli.js"
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

opt.clipboard = ""
opt.relativenumber = false

-- stylua: ignore start
opt.foldcolumn     = "auto:1" -- '0' is not bad
opt.foldlevel      = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable     = true

-- stylua: ignore
opt.fillchars = {
  eob       = " ",
  fold      = " ",
  foldopen  = "", --  
  foldsep   = " ",
  foldclose = "›", --  ›
}

-- stylua: ignore
opt.listchars = {
  tab      = "  ",
  nbsp     = "+",
  trail    = "·",
  extends  = "»",
  precedes = "«",
}

-- stylua: ignore start
opt.tabstop     = 4
opt.expandtab   = true
opt.smarttab    = true
opt.softtabstop = -1
opt.shiftwidth  = 0

-- views can only be fully collapsed with the global statusline
opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
opt.splitkeep = "screen"
