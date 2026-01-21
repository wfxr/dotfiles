---@diagnostic disable: missing-fields

return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  -- better increase/descrease
  {
    enabled = false,
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<Up>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<Down>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
        },
      })
    end,
  },

  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    dependencies = "rafamadriz/friendly-snippets",
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      keymap = {
        preset = "default",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          -- "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          snippets = {
            opts = {
              search_paths = { vim.fn.stdpath("config") .. "/snippets/native" },
            },
          },
        },
      },
      -- experimental signature help support
      signature = { enabled = true },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
  },

  {
    "Wansmer/treesj",
    keys = {
      { "gJ", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "gbprod/yanky.nvim",
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
      },
      filetypes = {
        ["*"] = true,
        ["neo-tree-popup"] = false,
        ["dap-repl"] = false,
        DressingInput = false,
        TelescopePrompt = false,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = false,
          accept_word = false,
          accept_line = false,
          next = "<M-n>",
          prev = "<M-p>",
          dismiss = "<C-l>",
        },
      },
    },
    keys = {
      {
        "<M-f>",
        function()
          local cs = require("copilot.suggestion")
          if cs.is_visible() then
            cs.accept_word()
          else
            vim.api.nvim_input("<S-Right>")
          end
        end,
        mode = "i",
        desc = "Accept Copilot Suggestion (Word)",
      },
      {
        "<M-e>",
        function()
          local cs = require("copilot.suggestion")
          if cs.is_visible() then
            cs.accept_line()
          else
            vim.api.nvim_input("<End>")
          end
        end,
        mode = "i",
        desc = "Accept Copilot Suggestion (Line)",
      },
      {
        "<M-Enter>",
        function()
          local cs = require("copilot.suggestion")
          if cs.is_visible() then
            cs.accept()
          else
            vim.api.nvim_input("<M-Enter>")
          end
        end,
        mode = "i",
        desc = "Accept Copilot Suggestion (All)",
      },
    },
  },

  {
    "nvim-mini/mini.surround",
    opts = {
      -- stylua: ignore start
      mappings = {
        add            = "sa", -- Add surrounding in Normal and Visual modes
        delete         = "sd", -- Delete surrounding
        find           = "sf", -- Find surrounding (to the right)
        find_left      = "sF", -- Find surrounding (to the left)
        highlight      = "sh", -- Highlight surrounding
        replace        = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },
}
