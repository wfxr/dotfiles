local ok, aerial = pcall(require, "aerial")
if not ok then
    return
end

aerial.setup {
    layout = {
        default_direction = "right",
        placement = "edge",
    },
}
vim.keymap.set("n", "<a-t>", "<cmd>AerialToggle<CR>")
