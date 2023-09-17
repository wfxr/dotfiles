local ok, window_picker = pcall(require, "window-picker")
if not ok then
    return
end

window_picker.setup {
    filter_rules = {
        -- filter using buffer options
        bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "notify" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = {},
        },
    },

    -- fg_color = KANAGAWA_COLORS.sumiInk0,

    -- if you have include_current_win == true, then current_win_hl_color will
    -- be highlighted using this background color
    -- current_win_hl_color = KANAGAWA_COLORS.waveBlue2,

    -- all the windows except the curren window will be highlighted using this color
    -- other_win_hl_color = KANAGAWA_COLORS.autumnGreen,
}

vim.keymap.set("n", "-", function()
    local window = window_picker.pick_window {
        autoselect_one = false,
        include_current_win = true,
    }
    if window then
        vim.api.nvim_set_current_win(window)
    end
end)
