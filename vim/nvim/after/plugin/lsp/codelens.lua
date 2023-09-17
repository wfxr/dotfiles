local group = vim.api.nvim_create_augroup("lsp_document_codelens", {})

---@param bufnr number
local function buf_autocmd_codelens(bufnr)
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost", "CursorHold" }, {
        buffer = bufnr,
        group = group,
        callback = function()
            vim.lsp.codelens.refresh()
        end,
    })
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.supports_method "textDocument/codeLens" then
            buf_autocmd_codelens(bufnr)
            vim.schedule(vim.lsp.codelens.refresh)
        end
    end,
})
