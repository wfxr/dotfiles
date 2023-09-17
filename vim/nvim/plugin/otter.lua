local ok, otter = pcall(require, "otter")
if not ok then
    return
end

local function setup_otter()
    otter.activate({ "python", "lua", "bash" }, true)
    vim.keymap.set("n", "gd", otter.ask_definition, {
        buffer = true,
    })
    vim.keymap.set("n", "K", otter.ask_hover, {
        buffer = true,
    })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "Markdown" },
    callback = setup_otter,
})

-- Needed because when an LSP attaches it overrides the otter keymaps which are registered before LSPs
vim.api.nvim_create_autocmd("LspAttach", {
    callback = vim.schedule_wrap(function(args)
        if vim.bo[args.buf].filetype == "markdown" then
            setup_otter()
        end
    end),
})
