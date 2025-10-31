---@diagnostic disable: missing-fields

return {
  -- neodev
  -- { "folke/neodev.nvim" },

  -- tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      -- Automatically format on save
      servers = {
        ["*"] = {
          keys = {
            -- { "<c-k>", mode = "i", false },
            -- { "gI", false },
            {
              "<M-enter>",
              "<leader>ca",
              mode = { "n", "v" },
              has = "codeAction",
              remap = true,
              desc = "Code Action",
            },
          },
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
                    vim.lsp.protocol.make_client_capabilities().textDocument.codeAction.resolveSupport.properties,
                    {
                      "documentation",
                      "detail",
                      "additionalTextEdits",
                    }
                  ),
                },
              },
            },
          },
        },
        bashls = {},
        clangd = {},
        dockerls = {},
        gopls = {},
        rust_analyzer = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              hover = { expandAlias = false },
              type = {
                castNumberToInteger = true,
                inferParamType = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
            },
          },
        },
        vimls = {},
      },
      setup = {
        -- use rustaceanvim.mason instead of rust_analyzer installed by mason to avoid toolchain mismatch
        rust_analyzer = function()
          return true
        end,
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["markdown"] = { { "prettierd", "prettier" } },
        ["markdown.mdx"] = { { "prettierd", "prettier" } },
        ["javascript"] = { "dprint" },
        ["javascriptreact"] = { "dprint" },
        ["typescript"] = { "dprint" },
        ["typescriptreact"] = { "dprint" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "4", "-ci" },
        },
        dprint = {
          condition = function(ctx)
            return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene", "luacheck" },
      },
      linters = {
        selene = {
          condition = function(_ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ "selene.toml" }, { path = root, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(_ctx)
            local root = LazyVim.root.get({ normalize = true })
            if root ~= vim.uv.cwd() then
              return false
            end
            return vim.fs.find({ ".luacheckrc" }, { path = root, upward = true })[1]
          end,
        },
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    lazy = true,
    opts = function(_, opts)
      return vim.tbl_extend("force", opts, {
        -- Plugin configuration
        tools = {
          inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "  󰮹 ",
            only_current_line = true,
            other_hints_prefix = "  󰮺 ",
          },
        },
        -- LSP configuration
        server = {
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              procMacro = {
                enable = true,
              },
            },
          },
        },
        -- DAP configuration
        dap = {},
      })
    end,
  },

  {
    "smjonas/inc-rename.nvim",
    enabled = false,
  },
}
