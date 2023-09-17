local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns.setup {
    current_line_blame = false,
    current_line_blame_opts = {
        delay = vim.o.updatetime,
    },
    on_attach = function(bufnr)
        vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            gitsigns.next_hunk()
        end, { buffer = bufnr })
        vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            gitsigns.prev_hunk()
        end, { buffer = bufnr })

        vim.keymap.set("n", "<leader>ga", gitsigns.stage_hunk, { buffer = bufnr })
        vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr })
        vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { buffer = bufnr })
        vim.keymap.set("n", "<leader>gu", gitsigns.undo_stage_hunk, { buffer = bufnr })
        vim.keymap.set("n", "<leader>gq", function()
            gitsigns.setqflist "all"
        end, { buffer = bufnr })
        vim.keymap.set("n", "<leader>g.q", function()
            gitsigns.setqflist(0)
        end, { buffer = bufnr })

        vim.keymap.set("o", "ah", gitsigns.select_hunk, { buffer = bufnr })
        vim.keymap.set("v", "ah", gitsigns.select_hunk, { buffer = bufnr })
    end,
}
