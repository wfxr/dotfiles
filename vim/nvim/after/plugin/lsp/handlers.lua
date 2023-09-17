local rename = vim.lsp.handlers["textDocument/rename"]

local function parse_edits(entries, bufnr, text_edits)
    for _, edit in ipairs(text_edits) do
        local start_line = edit.range.start.line + 1
        local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]

        table.insert(entries, {
            bufnr = bufnr,
            lnum = start_line,
            col = edit.range.start.character + 1,
            text = line,
        })
    end
end

-- Populates the quickfix list with all rename locations.
vim.lsp.handlers["textDocument/rename"] = function(err, result, ...)
    rename(err, result, ...)
    if err then
        return
    end

    local entries = {}
    if result.changes then
        for uri, edits in pairs(result.changes) do
            local bufnr = vim.uri_to_bufnr(uri)
            parse_edits(entries, bufnr, edits)
        end
    elseif result.documentChanges then
        for _, doc_change in ipairs(result.documentChanges) do
            if doc_change.textDocument then
                local bufnr = vim.uri_to_bufnr(doc_change.textDocument.uri)
                parse_edits(entries, bufnr, doc_change.edits)
            else
                vim.notify(("Failed to parse TextDocumentEdit of kind: %s"):format(doc_change.kind or "N/A"))
            end
        end
    end
    vim.fn.setqflist(entries)
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "solid",
})
