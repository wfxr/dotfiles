local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
    opt = true,
    event = "BufReadPre",
    config = conf.nvim_lsp,
}
completion["jose-elias-alvarez/null-ls.nvim"] = {
    opt = false,
    requires = { 'nvim-lua/plenary.nvim' },
    config = function ()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
            -- full list: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.rustfmt,
                null_ls.builtins.code_actions.gitsigns,
                null_ls.builtins.code_actions.shellcheck,
                null_ls.builtins.diagnostics.actionlint,
                null_ls.builtins.diagnostics.buf, -- protobuf
                null_ls.builtins.diagnostics.checkmake, -- make
                -- null_ls.builtins.diagnostics.codespell,
                null_ls.builtins.diagnostics.golangci_lint,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.rustfmt,
                null_ls.builtins.formatting.shfmt,
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                            vim.lsp.buf.formatting_sync()
                        end,
                    })
                end
            end,
        })
    end
}
completion["williamboman/nvim-lsp-installer"] = {
    opt = false,
}
completion["tami5/lspsaga.nvim"] = {
    opt = true,
    after = "nvim-lspconfig",
    config = function ()
        require("lspsaga").init_lsp_saga({
            rename_prompt_prefix = '❯'
        })
    end
}
completion["stevearc/aerial.nvim"] = {
    opt = true,
    after = "nvim-lspconfig",
    config = conf.aerial,
}
completion["ray-x/lsp_signature.nvim"] = { opt = true, after = "nvim-lspconfig" }
completion["hrsh7th/nvim-cmp"] = {
    config = conf.cmp,
    event = "InsertEnter",
    requires = {
        { "lukas-reineke/cmp-under-comparator" },
        { "saadparwaiz1/cmp_luasnip",   after = "LuaSnip"      },
        { "hrsh7th/cmp-nvim-lsp",       after = "cmp_luasnip"  },
        { "hrsh7th/cmp-nvim-lua",       after = "cmp-nvim-lsp" },
        { "hrsh7th/cmp-path",           after = "cmp-nvim-lua" },
        { "f3fora/cmp-spell",           after = "cmp-path"     },
        { "hrsh7th/cmp-buffer",         after = "cmp-spell"    },
        -- { "kdheepak/cmp-latex-symbols", after = "cmp-buffer"   },
        -- { "andersevenrud/cmp-tmux", after = "cmp-nvim-lua" },
        -- {
        --     'tzachar/cmp-tabnine',
        --     run = './install.sh',
        --     after = 'cmp-spell',
        --     config = conf.tabnine
        -- }
    },
}
completion["L3MON4D3/LuaSnip"] = {
    after = "nvim-cmp",
    config = conf.luasnip,
    requires = "honza/vim-snippets",
}
completion["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = conf.autopairs,
}
completion["github/copilot.vim"] = { opt = true, cmd = "Copilot" }

return completion
