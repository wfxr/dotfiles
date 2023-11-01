local ok, window_picker = pcall(require, "window-picker")
if not ok then
    return
end

window_picker.setup({
    filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        -- filter using buffer options
        bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal', "quickfix" },
        },
    },
})

vim.keymap.set("n", "-", function()
    local window = window_picker.pick_window {
        autoselect_one = false,
        include_current_win = true,
    }
    if window then
        vim.api.nvim_set_current_win(window)
    end
end)
