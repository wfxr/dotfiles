local ok, glance = pcall(require, "glance")
if not ok then
    return
end

glance.setup {
    mappings = {
        list = {
            ["<C-j>"] = glance.actions.next_location,
            ["<C-k>"] = glance.actions.previous_location,
            ["<C-t>"] = glance.actions.jump_tab,
            ["<C-v>"] = glance.actions.jump_vsplit,
            ["<C-x>"] = glance.actions.jump_split,
            ["s"] = false,
            ["t"] = false,
            ["v"] = false,
            ["<C-q>"] = glance.actions.quickfix,
        },
    },
    hooks = {
        -- Don’t open glance when there is only one result and it is located in the current buffer, open otherwise.
        before_open = function(results, open, jump)
            local uri = vim.uri_from_bufnr(0)
            if #results == 1 then
                local target_uri = results[1].uri or results[1].targetUri

                if target_uri == uri then
                    jump(results[1])
                else
                    open(results)
                end
            else
                open(results)
            end
        end,
    },
}
