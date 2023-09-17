local deps_ok, cmp, types, luasnip, cmp_dap, lspkind, cmp_git = pcall(function()
    return require "cmp",
        require "cmp.types",
        require "luasnip",
        require "cmp_dap",
        require "lspkind",
        require "cmp_git"
end)
if not deps_ok then
    return
end
local mapping = cmp.mapping

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup {
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or cmp_dap.is_dap_buffer()
    end,
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-d>"] = mapping(mapping.scroll_docs(8), { "i" }),
        ["<C-u>"] = mapping(mapping.scroll_docs(-8), { "i" }),
        ["<CR>"] = mapping.confirm { select = false },
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-n>"] = mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
        ["<C-p>"] = mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
        ["<C-j>"] = cmp.mapping(function()
            local luasnip = require("luasnip")
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
            local luasnip = require("luasnip")
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "tmux" },
        { name = "rg" },
        { name = "git" },
        { name = "calc" },
        { name = "luasnip" },
    },
}

cmp_git.setup {
    enableRemoteUrlRewrites = true,
}

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
        { name = "dap" },
    },
})
