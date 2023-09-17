local ok, hover = pcall(require, "hover")
if not ok then
    return
end

hover.setup {
    init = function()
        require "hover.providers.lsp"
        require "hover.providers.gh"
        require "hover.providers.man"
        require "hover.providers.dictionary"
    end,
    title = true,
    preview_window = true,
}

vim.keymap.set("n", "K", hover.hover, { desc = "hover.nvim" })
vim.keymap.set("n", "gK", hover.hover_select, { desc = "hover.nvim (select)" })
