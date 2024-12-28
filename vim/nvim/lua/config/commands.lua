-- Function to remove trailing spaces
local function strip_trailing_spaces()
  -- Save the current position of the cursor
  local pos = vim.fn.getpos(".")

  vim.cmd([[%s/\s\+$//e]])

  -- Restore the cursor position
  vim.fn.setpos(".", pos)
end
vim.api.nvim_create_user_command("StripTrailingSpaces", strip_trailing_spaces, {})
