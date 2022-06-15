vim.cmd([[packadd nvim-lsp-installer]])
vim.cmd([[packadd cmp-nvim-lsp]])
vim.cmd([[packadd aerial.nvim]])
vim.cmd([[packadd vim-illuminate]])

local nvim_lsp = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")

local signs = {
    { name = "DiagnosticSignError", text = "••" }, -- 
    { name = "DiagnosticSignWarn",  text = "•"  }, -- 
    { name = "DiagnosticSignHint",  text = ""  }, -- 
    { name = "DiagnosticSignInfo",  text = ""  }, --     כֿ 
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

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
    if server.name == "rust_analyzer" then
        require("rust-tools").setup({
            tools = {
                -- rust-tools options
                -- Automatically set inlay hints (type hints)
                autoSetHints = true,
                -- Whether to show hover actions inside the hover window
                -- This overrides the default hover handler
                hover_with_actions = true,
                runnables = {
                    -- whether to use telescope for selection menu or not
                    use_telescope = true,

                    -- rest of the opts are forwarded to telescope
                },
                debuggables = {
                    -- whether to use telescope for selection menu or not
                    use_telescope = true,

                    -- rest of the opts are forwarded to telescope
                },
                -- These apply to the default RustSetInlayHints command
                inlay_hints = {
                    -- Only show inlay hints for the current line
                    only_current_line = false,
                    -- Event which triggers a refersh of the inlay hints.
                    -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                    -- not that this may cause  higher CPU usage.
                    -- This option is only respected when only_current_line and
                    -- autoSetHints both are true.
                    only_current_line_autocmd = "CursorHold",
                    -- wheter to show parameter hints with the inlay hints or not
                    show_parameter_hints = false,
                    -- prefix for parameter hints
                    parameter_hints_prefix = "« ",
                    -- prefix for all the other hints (type, chaining)
                    other_hints_prefix = " » ",
                    -- whether to align to the length of the longest line in the file
                    max_len_align = false,
                    -- padding from the left if max_len_align is true
                    max_len_align_padding = 1,
                    -- whether to align to the extreme right or not
                    right_align = false,
                    -- padding from the right if right_align is true
                    right_align_padding = 7,
                },
                hover_actions = {
                    -- the border that is used for the hover window
                    -- see vim.api.nvim_open_win()
                    border = {
                        { "┏", "FloatBorder" },
                        { "─", "FloatBorder" },
                        { "┓", "FloatBorder" },
                        { "│", "FloatBorder" },
                        { "┛", "FloatBorder" },
                        { "─", "FloatBorder" },
                        { "┗", "FloatBorder" },
                        { "│", "FloatBorder" },
                    },
                    -- whether the hover action window gets automatically focused
                    auto_focus = false,
                },
            },
            -- all the opts to send to nvim-lspconfig
            -- these override the defaults set by rust-tools.nvim
            -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
            server = {
                capabilities = capabilities,
                on_attach = custom_attach,
            }
        })
    elseif server.name == "gopls" then
        nvim_lsp.gopls.setup({
            capabilities = capabilities,
            on_attach = custom_attach,
            flags = { debounce_text_changes = 500 },
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
            capabilities = capabilities,
            on_attach = custom_attach,
            flags = { debounce_text_changes = 500 },
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
