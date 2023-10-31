local deps_ok, lspconfig, util, cmp_lsp, mason_lspconfig = pcall(function()
    return require "lspconfig", require "lspconfig.util", require "cmp_nvim_lsp", require "mason-lspconfig"
end)
if not deps_ok then
    return
end

for type, icon in pairs(global.symbols.diagnostic) do
    local hl = "DiagnosticSign" .. type:gsub("^%l", string.upper)
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities
do
    local default_capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
            codeAction = {
                resolveSupport = {
                    properties = vim.list_extend(
                        default_capabilities.textDocument.codeAction.resolveSupport.properties,
                        {
                            "documentation",
                            "detail",
                            "additionalTextEdits",
                        }
                    ),
                },
            },
        },
    }
end

mason_lspconfig.setup()

mason_lspconfig.setup_handlers {
    function(server_name)
        lspconfig[server_name].setup {
            capabilities = capabilities,
        }
    end,
    ["jdtls"] = function()
        local function progress_handler()
            ---@type table<string, boolean>
            local tokens = {}
            ---@type table<string, boolean>
            local ready_projects = {}
            ---@param result {type:"Starting"|"Started"|"ServiceReady", message:string}
            return function(_, result, ctx)
                local cwd = vim.loop.cwd()
                if ready_projects[cwd] then
                    return
                end
                local token = tokens[cwd] or vim.tbl_count(tokens)
                if result.type == "Starting" and not tokens[cwd] then
                    tokens[cwd] = token
                    vim.lsp.handlers["$/progress"](nil, {
                        token = token,
                        value = {
                            kind = "begin",
                            title = "jdtls",
                            message = result.message,
                            percentage = 0,
                        },
                    }, ctx)
                elseif result.type == "Starting" then
                    local _, percentage_index = string.find(result.message, "^%d%d?%d?")
                    local percentage = 0
                    local message = result.message
                    if percentage_index then
                        percentage = tonumber(string.sub(result.message, 1, percentage_index))
                        message = string.sub(result.message, percentage_index + 3)
                    end

                    vim.lsp.handlers["$/progress"](nil, {
                        token = token,
                        value = {
                            kind = "report",
                            message = message,
                            percentage = percentage,
                        },
                    }, ctx)
                elseif result.type == "Started" then
                    vim.lsp.handlers["$/progress"](nil, {
                        token = token,
                        value = {
                            kind = "report",
                            message = result.message,
                            percentage = 100,
                        },
                    }, ctx)
                elseif result.type == "ServiceReady" then
                    ready_projects[cwd] = true
                    vim.lsp.handlers["$/progress"](nil, {
                        token = token,
                        value = {
                            kind = "end",
                            message = result.message,
                        },
                    }, ctx)
                end
            end
        end

        lspconfig.jdtls.setup {
            cmd = {
                "jdtls",
                "--jvm-arg=" .. string.format("-javaagent:%s", vim.fn.expand "$MASON/share/jdtls/lombok.jar"),
            },
            capabilities = capabilities,
            handlers = {
                ["language/status"] = progress_handler,
            },
        }
    end,
    ["jsonls"] = function()
        lspconfig.jsonls.setup {
            capabilities = capabilities,
            filetypes = { "json", "jsonc", "json5" },
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                },
            },
        }
    end,
    ["rust_analyzer"] = function()
        local rt = require "rust-tools"
        rt.setup {
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<leader><Enter>", rt.runnables.runnables, { buffer = bufnr })
                end,
            },
            tools = {
                inlay_hints = {
                    auto = true,
                    show_parameter_hints = false,
                    parameter_hints_prefix = "  󰮹 ",
                    only_current_line = true,
                    other_hints_prefix = "  󰮺 ",
                },
                executor = require("rust-tools/executors").toggleterm,
                hover_actions = { border = "solid" },
            },
            dap = {
                adapter = {
                    type = "server",
                    port = "${port}",
                    host = "127.0.0.1",
                    executable = {
                        command = "codelldb",
                        args = { "--port", "${port}" },
                    },
                },
            },
        }
    end,
    ["lua_ls"] = function()
        require("neodev").setup {}
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
                Lua = {
                    format = {
                        enable = false,
                    },
                    hint = {
                        enable = true,
                        arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                        await = true,
                        paramName = "All", -- "All", "Literal", "Disable"
                        paramType = true,
                        semicolon = "Disable", -- "All", "SameLine", "Disable"
                        setType = true,
                    },
                    diagnostics = {
                        globals = { "P", "vim" },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                        },
                    },
                },
            },
        }
    end,
    ["yamlls"] = function()
        lspconfig.yamlls.setup {
            capabilities = capabilities,
            settings = {
                yaml = {
                    hover = true,
                    completion = true,
                    validate = true,
                    schemas = require("schemastore").yaml.schemas {
                        extra = {
                            {
                                fileMatch = { "**/packages/*/package.yaml" },
                                name = "Mason Registry",
                                description = "Mason Registry",
                                url = "https://raw.githubusercontent.com/mason-org/json-schema/main/bundled-schema.json",
                            },
                        },
                    },
                },
            },
        }
    end,
}
