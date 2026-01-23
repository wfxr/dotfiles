-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = augroup("auto_cursorline_active"),
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto_cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto_cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = augroup("auto_cursorline_deactive"),
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto_cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("formatoptions"),
  callback = function()
    vim.opt_local.formatoptions:remove("t") -- Don't auto wrap text using textwidth
    vim.opt_local.formatoptions:remove("c") -- Don't auto wrap comments using textwidth
    vim.opt_local.formatoptions:remove("o") -- Don't continue comments with o and O
  end,
})

-- Disable autoformat for some filetypes (Re-enable by `<leader>uf`)
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("disable_autoformat"),
  pattern = { "yaml", "toml" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Disable diagnostics for some filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("disable_diagnostics"),
  pattern = { "markdown" },
  callback = function(event)
    vim.diagnostic.enable(false, { bufnr = event.buf })
  end,
})

-- Auto enter insert mode when opening a terminal
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  command = "startinsert",
})
