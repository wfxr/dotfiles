local conf = require("telescope.config").values
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local builtin = require "telescope.builtin"

local M = {}

M.document_diagnostics = function()
    builtin.diagnostics { bufnr = 0 }
end

M.workspace_diagnostics = function()
    builtin.diagnostics()
end

M.definitions = function()
    builtin.lsp_definitions()
end

M.type_definition = function()
    builtin.lsp_type_definitions()
end

M.references = function()
    builtin.lsp_references()
end

M.buffer_references = function(opts)
    opts = opts or {}
    local params = vim.lsp.util.make_position_params(opts.winnr)
    params.context = { includeDeclaration = true }

    vim.lsp.buf_request(opts.bufnr, "textDocument/references", params, function(err, result, ctx, _config)
        if err then
            vim.api.nvim_err_writeln("Error when finding references: " .. err.message)
            return
        end

        local locations = {}
        if result then
            local filtered_result = result
            local buf_uri = vim.uri_from_bufnr(0)
            filtered_result = vim.tbl_filter(function(location)
                return (location.uri or location.targetUri) == buf_uri
            end, result)

            locations = vim.lsp.util.locations_to_items(
                filtered_result,
                vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
            ) or {}
        end

        if vim.tbl_isempty(locations) then
            return
        end

        pickers
            .new(opts, {
                prompt_title = "LSP References (filtered)",
                finder = finders.new_table {
                    results = locations,
                    entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
                },
                previewer = conf.qflist_previewer(opts),
                sorter = conf.generic_sorter(opts),
            })
            :find()
    end)
end

M.implementations = function()
    builtin.lsp_implementations()
end

M.workspace_symbols = function()
    local query = vim.fn.input "Query >"
    if query ~= "" then
        vim.cmd.Telescope { "lsp_workspace_symbols", "query=" .. query }
    else
        builtin.lsp_workspace_symbols()
    end
end

M.document_symbols = function()
    local symbols = {
        "All",
        "Variable",
        "Function",
        "Constant",
        "Class",
        "Property",
        "Method",
        "Enum",
        "Interface",
        "Boolean",
        "Number",
        "String",
        "Array",
        "Constructor",
    }

    vim.ui.select(symbols, { prompt = "Select which symbol" }, function(item)
        if item == "All" then
            builtin.lsp_document_symbols()
        else
            builtin.lsp_document_symbols { symbols = item }
        end
    end)
end

return M
