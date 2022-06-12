vim.cmd([[packadd nvim-lsp-installer]])
vim.cmd([[packadd lsp_signature.nvim]])
vim.cmd([[packadd lspsaga.nvim]])
vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd aerial.nvim]])
vim.cmd([[packadd vim-illuminate]])

local nvim_lsp = require("lspconfig")
local saga = require("lspsaga")
local lsp_installer = require("nvim-lsp-installer")

-- Override diagnostics symbol

saga.init_lsp_saga({
    error_sign = "••", -- 
    warn_sign = "•", -- 
    hint_sign = "", -- 
    infor_sign = "", --     כֿ 
    code_action_prompt = {
        enable = false,
        sign = false,
        sign_priority = 40,
        virtual_text = true,
    },
    finder_action_keys = {
        open = 'o',
        vsplit = '<C-v>',
        split = 'C-x',
        quit = { '<C-[>', '<C-c>', '<Esc>' },
        scroll_down = '<C-d>',
        scroll_up = '<C-u>',
    },
    code_action_keys   = { quit = { '<C-[>', '<C-c>', '<Esc>' }, exec = '<CR>' },
    rename_action_keys = { quit = { '<C-[>', '<C-c>', '<Esc>' }, exec = '<CR>' },
})

lsp_installer.setup({
    ensure_installed = {
        "golangci_lint_ls",
        "rust_analyzer",
        "bashls",
        "sumneko_lua",
    },
    ui = {
        icons = {
            server_installed = "",
            server_pending = "➜",
            server_uninstalled = "◍",
        },
    },
    keymaps = {
        -- Keymap to expand a server in the UI
        toggle_server_expand = "o",
        -- Keymap to install the server under the current cursor position
        install_server = "i",
        -- Keymap to reinstall/update the server under the current cursor position
        update_server = "u",
        -- Keymap to check for new version for the server under the current cursor position
        check_server_version = "c",
        -- Keymap to update all installed servers
        update_all_servers = "U",
        -- Keymap to check which installed servers are outdated
        check_outdated_servers = "C",
        -- Keymap to uninstall a server
        uninstall_server = "X",
    },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function custom_attach(client, bufnr)
    require("lsp_signature").on_attach({
        bind = true,
        use_lspsaga = false,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hi_parameter = "Search",
        handler_opts = { "double" },
    })
    require("aerial").on_attach(client)
    require("illuminate").on_attach(client)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

-- Override server settings here

for _, server in ipairs(lsp_installer.get_installed_servers()) do
    if server.name == "gopls" then
        nvim_lsp.gopls.setup({
            on_attach = function(client, bufnr)
                custom_attach(client, bufnr)
            end,
            flags = { debounce_text_changes = 500 },
            capabilities = capabilities,
            settings = {
                gopls = {
                    usePlaceholders = true,
                    analyses = {
                        nilness = true,
                        shadow = false,
                        unusedparams = true,
                        unusewrites = true,
                    },
                },
            },
        })
    elseif server.name == "sumneko_lua" then
        nvim_lsp.sumneko_lua.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                client.server_capabilities.document_formatting = false
                custom_attach(client, bufnr)
            end,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim", "packer_plugins" } },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                    telemetry = { enable = false },
                },
            },
        })
    elseif server.name == "jsonls" then
        nvim_lsp.jsonls.setup({
            flags = { debounce_text_changes = 500 },
            capabilities = capabilities,
            on_attach = custom_attach,
            settings = {
                json = {
                    -- Schemas https://www.schemastore.org
                    schemas = {
                        {
                            fileMatch = { "package.json" },
                            url = "https://json.schemastore.org/package.json",
                        },
                        {
                            fileMatch = { "tsconfig*.json" },
                            url = "https://json.schemastore.org/tsconfig.json",
                        },
                        {
                            fileMatch = {
                                ".prettierrc",
                                ".prettierrc.json",
                                "prettier.config.json",
                            },
                            url = "https://json.schemastore.org/prettierrc.json",
                        },
                        {
                            fileMatch = { ".eslintrc", ".eslintrc.json" },
                            url = "https://json.schemastore.org/eslintrc.json",
                        },
                        {
                            fileMatch = {
                                ".babelrc",
                                ".babelrc.json",
                                "babel.config.json",
                            },
                            url = "https://json.schemastore.org/babelrc.json",
                        },
                        {
                            fileMatch = { "lerna.json" },
                            url = "https://json.schemastore.org/lerna.json",
                        },
                        {
                            fileMatch = {
                                ".stylelintrc",
                                ".stylelintrc.json",
                                "stylelint.config.json",
                            },
                            url = "http://json.schemastore.org/stylelintrc.json",
                        },
                        {
                            fileMatch = { "/.github/workflows/*" },
                            url = "https://json.schemastore.org/github-workflow.json",
                        },
                    },
                },
            },
        })
    else
        nvim_lsp[server.name].setup({
            capabilities = capabilities,
            on_attach = function(client)
                client.server_capabilities.document_formatting = false
                custom_attach(client)
            end,
        })
    end
end
