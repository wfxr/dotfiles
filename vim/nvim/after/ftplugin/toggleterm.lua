local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<C-p>", [[<cmd>startinsert | call feedkeys("\<C-p>")<cr>]], { buffer = true, nowait = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    buffer = bufnr,
    callback = function()
        local bufinfo = assert(vim.fn.getbufinfo(vim.fn.bufnr())[1])
        local should_trigger_insert_mode = vim.b.last_insert_line == bufinfo.lnum
        if should_trigger_insert_mode then
            vim.cmd.startinsert()
        end
    end,
})

vim.api.nvim_create_autocmd({ "TermLeave" }, {
    buffer = bufnr,
    callback = function()
        local bufinfo = assert(vim.fn.getbufinfo(vim.fn.bufnr())[1])
        vim.b.last_insert_line = bufinfo.lnum
    end,
})

vim.schedule(function()
    vim.opt.statuscolumn = ""
end)
