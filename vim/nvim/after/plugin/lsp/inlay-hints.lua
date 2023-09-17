local function supports_inlay_hints(bufnr)
    local clients = vim.lsp.get_active_clients { bufnr = bufnr }
    for _, client in ipairs(clients) do
        if client.server_capabilities.inlayHintProvider then
            return true
        end
    end
    return false
end

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
        if supports_inlay_hints(args.buf) then
            vim.lsp.inlay_hint(args.buf, true)
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        if supports_inlay_hints(args.buf) then
            vim.defer_fn(function()
                vim.lsp.inlay_hint(args.buf, true)
            end, 3000)
        end
    end,
})
