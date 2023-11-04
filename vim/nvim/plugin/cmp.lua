---@diagnostic disable: missing-fields
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

cmp.setup {
    -- enabled = function()
    --     return vim.api.nvim_get_option_value("buftype", {}) ~= "prompt" or cmp_dap.is_dap_buffer()
    -- end,
    formatting = {
        format = lspkind.cmp_format {
            mode = 'symbol_text',
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
        ["<CR>"]  = mapping.confirm { select = false },
        ["<Tab>"] = mapping.confirm({ select = true }),
        ["<C-n>"] = mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
        ["<C-p>"] = mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
        ["<C-j>"] = mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            end
        end, { "i", "s" }),
        ["<C-k>"] = mapping(function(fallback)
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
        { name = "calc" },
        { name = "luasnip" },
    },
}

cmp_git.setup {
    enableRemoteUrlRewrites = true,
}

cmp.setup.filetype('gitcommit', {
    sources = {
        { name = 'git' },
        { name = 'buffer' }
    }
})

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
        { name = "dap" },
    },
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'cmdline' },
        { name = 'path' },
        { name = 'buffer' },
    }
})
