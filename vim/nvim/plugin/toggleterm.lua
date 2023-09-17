local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
    return
end

toggleterm.setup {
    insert_mappings = false,
    env = {
        MANPAGER = "less -X",
    },
    terminal_mappings = false,
    start_in_insert = true,
    persist_mode = true,
    auto_scroll = false,
    open_mapping = [[<space>t]],
    highlights = {
        CursorLineSign = { link = "DarkenedPanel" },
        -- Normal = { guibg = KANAGAWA_COLORS.sumiInk0 },
    },
}
