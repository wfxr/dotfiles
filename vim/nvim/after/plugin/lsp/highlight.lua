local deps_ok, ts_utils = pcall(function()
    return require "nvim-treesitter.ts_utils"
end)

if not deps_ok then
    return
end

local function highlight_references()
    local node = ts_utils.get_node_at_cursor()
    while node ~= nil do
        local node_type = node:type()
        if
            node_type == "string"
            or node_type == "string_fragment"
            or node_type == "template_string"
            or node_type == "document" -- for inline gql`` strings
        then
            -- who wants to highlight a string? i don't. yuck
            return
        end
        node = node:parent()
    end
    vim.lsp.buf.document_highlight()
end

local group = vim.api.nvim_create_augroup("lsp_document_highlight", {})

---@param bufnr integer
local function buf_autocmd_document_highlight(bufnr)
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        group = group,
        callback = highlight_references,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = bufnr,
        group = group,
        callback = function()
            vim.lsp.buf.clear_references()
        end,
    })
end
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.supports_method "textDocument/documentHighlight" then
            buf_autocmd_document_highlight(bufnr)
        end
    end,
})
