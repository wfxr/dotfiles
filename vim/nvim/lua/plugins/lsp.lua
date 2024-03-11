---@diagnostic disable: missing-fields

-- stylua: ignore start
local hover_map        = { "K",  function() require("hover").hover()        end, silent = true, desc = "hover.nvim"           }
local hover_select_map = { "gK", function() require("hover").hover_select() end, silent = true, desc = "hover.nvim  (select)" }

return {
  -- neodev
  -- { "folke/neodev.nvim" },

  -- tools
  {
    "williamboman/mason.nvim",
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

  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").register({
        name = "EN->ZH",
        enabled = function()
          return true
        end,
        execute = require("hover.async").void(function(done)
          local word = vim.fn.expand("<cword>")

          local job = require("hover.async.job").job

          local output = job({
            "clitrans",
            word,
          })

          local results = { output }
          done(results and { lines = results, filetype = "markdown" })
        end),
      })
      require("hover").setup({
        init = function()
          require("hover.providers.lsp")
          require("hover.providers.gh")
          require("hover.providers.man")
          require("hover.providers.dictionary")
        end,
        title = true,
        preview_window = true,
        preview_opts = {
          border = "rounded",
        },
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- stylua: ignore start
      keys[#keys + 1] = { "<c-k>", mode = "i", false }
      keys[#keys + 1] = { "gI", false }
      keys[#keys + 1] = hover_map
      keys[#keys + 1] = hover_select_map
      keys[#keys + 1] = { "<M-enter>", "<leader>ca", mode = { "n", "v" }, has = "codeAction", remap = true, desc = "Code Action",  }
    end,
    keys = {
      -- stylua: ignore start
      { "gi", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation", },
    },
    opts = {
      inlay_hints = { enabled = false },
      -- Automatically format on save
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
      ---@type lspconfig.options
      servers = {
        bashls = {},
        clangd = {},
        dockerls = {},
        gopls = {},
        rust_analyzer = {
          keys = {
            hover_map,
            hover_select_map,
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hover = { expandAlias = false },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
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
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        vimls = {},
      },
      setup = {},
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
        markdown = { "markdownlint" },
      },
      linters = {
        selene = {
          condition = function(ctx)
            return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        luacheck = {
          condition = function(ctx)
            return vim.fs.find({ ".luacheckrc" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    ft = { 'rust' },
    lazy = true,
    opts = function(_, opts)
      return vim.tbl_extend("force", opts, {
        tools = {
          inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "  󰮹 ",
            only_current_line = true,
            other_hints_prefix = "  󰮺 ",
          },
        }
      })
    end,
  }
}
