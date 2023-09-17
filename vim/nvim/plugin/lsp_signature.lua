local ok, lsp_signature = pcall(require, "lsp_signature")
if not ok then
    return
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        lsp_signature.on_attach({
            bind = true,
            floating_window = false,
            hint_prefix = "",
            hint_scheme = "Comment",
        }, bufnr)
    end,
})
