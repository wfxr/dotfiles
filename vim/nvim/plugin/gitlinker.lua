local ok, gitlinker = pcall(require, "gitlinker")
if not ok then
    return
end

gitlinker.setup()

vim.keymap.set("n", "<leader>go", function()
    gitlinker.get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
end)

vim.keymap.set("v", "<leader>go", function()
    gitlinker.get_buf_range_url("v", { action_callback = require("gitlinker.actions").open_in_browser })
end)
