-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    vim.opt_local.formatoptions:remove("t") -- Don't auto wrap text using textwidth
    vim.opt_local.formatoptions:remove("c") -- Don't auto wrap comments using textwidth
    vim.opt_local.formatoptions:remove("o") -- Don't continue comments with o and O
  end,
})

-- Copilot seems not enabled when entering insert mode by default for some reason.
-- So we enable it manually here. This is a workaround (#6).
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.cmd("Copilot enable")
  end,
})

-- Disable autoformat for some filetypes (Re-enable by `<leader>uf`)
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "yaml", "toml" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Disable diagnostics for some filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.diagnostic.enable(false)
  end,
})
