local ok, tint = pcall(require, "tint")
if not ok then
    return
end

local DONT_TINT = true
local TINT = false

tint.setup {
    tint = -20,
    saturation = 0.6,
    highlight_ignore_patterns = {
        "LspInlayHint.*",
        "WinBar.*",
        "WinSeparator",
        "IndentBlankline.*",
        "SignColumn",
        "EndOfBuffer",
        "Neotest*", -- for some reason Neotest window get tinted when it shouldn't
    },
    window_ignore_function = function(winid)
        -- Don't tint floating windows.
        if vim.api.nvim_win_get_config(winid).relative ~= "" then
            return DONT_TINT
        end

        local bufnr = vim.api.nvim_win_get_buf(winid)
        -- Only tint normal buffers.
        if vim.api.nvim_buf_get_option(bufnr, "buftype") == "" then
            return TINT
        end
        return DONT_TINT
    end,
}
