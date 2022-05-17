require("modules.completion.formatting")

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
        "efm",
        "gopls",
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

-- Override default format setting

vim.lsp.handlers["textDocument/formatting"] = function(err, result, ctx)
    if err ~= nil or result == nil then
        return
    end
    if
        vim.api.nvim_buf_get_var(ctx.bufnr, "init_changedtick") == vim.api.nvim_buf_get_var(ctx.bufnr, "changedtick")
    then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, ctx.bufnr, "utf-16")
        vim.fn.winrestview(view)
        if ctx.bufnr == vim.api.nvim_get_current_buf() then
            vim.b.saving_format = true
            vim.cmd([[update]])
            vim.b.saving_format = false
        end
    end
end

local function custom_attach(client)
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

    if client.server_capabilities.document_formatting then
        vim.cmd([[augroup Format]])
        vim.cmd([[autocmd! * <buffer>]])
        vim.cmd([[autocmd BufWritePost <buffer> lua require'modules.completion.formatting'.format()]])
        vim.cmd([[augroup END]])
    end
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = nvim_lsp.util.validate_bufnr(bufnr)
    local clangd_client = nvim_lsp.util.get_active_client_by_name(bufnr, "clangd")
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    if clangd_client then
        clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
            if err then
                error(tostring(err))
            end
            if not result then
                print("Corresponding file can’t be determined")
                return
            end
            vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
        end)
    else
        print("method textDocument/switchSourceHeader is not supported by any servers active on the current buffer")
    end
end

-- Override server settings here

for _, server in ipairs(lsp_installer.get_installed_servers()) do
    if server.name == "gopls" then
        nvim_lsp.gopls.setup({
            on_attach = custom_attach,
            flags = { debounce_text_changes = 500 },
            capabilities = capabilities,
            settings = {
                gopls = {
                    usePlaceholders = true,
                    analyses = {
                        nilness = true,
                        shadow = true,
                        unusedparams = true,
                        unusewrites = true,
                    },
                },
            },
        })
    elseif server.name == "sumneko_lua" then
        nvim_lsp.sumneko_lua.setup({
            capabilities = capabilities,
            on_attach = function(client)
                client.server_capabilities.document_formatting = false
                custom_attach(client)
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
    elseif server.name == "clangd" then
        local copy_capabilities = capabilities
        copy_capabilities.offsetEncoding = { "utf-16" }
        nvim_lsp.clangd.setup({
            capabilities = copy_capabilities,
            single_file_support = true,
            on_attach = function(client)
                client.server_capabilities.document_formatting = false
                custom_attach(client)
            end,
            args = {
                "--background-index",
                "-std=c++20",
                "--pch-storage=memory",
                "--clang-tidy",
                "--suggest-missing-includes",
            },
            commands = {
                ClangdSwitchSourceHeader = {
                    function()
                        switch_source_header_splitcmd(0, "edit")
                    end,
                    description = "Open source/header in current buffer",
                },
                ClangdSwitchSourceHeaderVSplit = {
                    function()
                        switch_source_header_splitcmd(0, "vsplit")
                    end,
                    description = "Open source/header in a new vsplit",
                },
                ClangdSwitchSourceHeaderSplit = {
                    function()
                        switch_source_header_splitcmd(0, "split")
                    end,
                    description = "Open source/header in a new split",
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

-- https://github.com/vscode-langservers/vscode-html-languageserver-bin

nvim_lsp.html.setup({
    cmd = { "html-languageserver", "--stdio" },
    filetypes = { "html" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = { css = true, javascript = true },
    },
    settings = {},
    single_file_support = true,
    flags = { debounce_text_changes = 500 },
    capabilities = capabilities,
    on_attach = function(client)
        client.server_capabilities.document_formatting = false
        custom_attach(client)
    end,
})

local efmls = require("efmls-configs")

-- Init `efm-langserver` here.

efmls.init({
    on_attach = custom_attach,
    capabilities = capabilities,
    init_options = { documentFormatting = true, codeAction = true },
})

-- Require `efmls-configs-nvim`'s config here

local vint = require("efmls-configs.linters.vint")
local clangtidy = require("efmls-configs.linters.clang_tidy")
local eslint = require("efmls-configs.linters.eslint")
local flake8 = require("efmls-configs.linters.flake8")
local shellcheck = require("efmls-configs.linters.shellcheck")

local black = require("efmls-configs.formatters.black")
local luafmt = require("efmls-configs.formatters.stylua")
local clangfmt = require("efmls-configs.formatters.clang_format")
local prettier = require("efmls-configs.formatters.prettier")
local shfmt = require("efmls-configs.formatters.shfmt")

-- Add your own config for formatter and linter here

-- local rustfmt = require("modules.completion.efm.formatters.rustfmt")

-- Override default config here

flake8 = vim.tbl_extend("force", flake8, {
    prefix = "flake8: max-line-length=160, ignore F403 and F405",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = { "%f:%l:%c: %t%n%n%n %m" },
    lintCommand = "flake8 --max-line-length 160 --extend-ignore F403,F405 --format '%(path)s:%(row)d:%(col)d: %(code)s %(code)s %(text)s' --stdin-display-name ${INPUT} -",
})

-- Setup formatter and linter for efmls here

efmls.setup({
    vim = { formatter = vint },
    lua = { formatter = luafmt },
    c = { formatter = clangfmt, linter = clangtidy },
    cpp = { formatter = clangfmt, linter = clangtidy },
    python = { formatter = black },
    vue = { formatter = prettier },
    typescript = { formatter = prettier, linter = eslint },
    javascript = { formatter = prettier, linter = eslint },
    typescriptreact = { formatter = prettier, linter = eslint },
    javascriptreact = { formatter = prettier, linter = eslint },
    yaml = { formatter = prettier },
    html = { formatter = prettier },
    css = { formatter = prettier },
    scss = { formatter = prettier },
    sh = { formatter = shfmt, linter = shellcheck },
    markdown = { formatter = prettier },
    -- rust = {formatter = rustfmt},
})
