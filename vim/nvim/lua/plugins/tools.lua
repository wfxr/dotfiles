return {
  { "pwntester/octo.nvim", opts = {}, cmd = "Octo" },

  -- better diffing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },

  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPTActAs", "ChatGPT" },
    opts = {},
  },

  {
    "ojroques/nvim-osc52",
    config = function()
      vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
      vim.keymap.set("n", "<c-y>", "<leader>y_", { remap = true })
      vim.keymap.set("x", "<c-y>", require("osc52").copy_visual)
    end,
  },

  {
    "tpope/vim-fugitive",
    Event = "VeryLazy",
  },

  {
    "NvChad/nvim-colorizer.lua",
    ft = { "vim", "lua", "tmux", "zsh", "html", "css", "sass", "typescript", "javascript" },
    config = function()
      require("colorizer").setup({})
    end,
  },

  {
    "nvim-neorg/neorg",
    cmd = { "Neorg" },
    ft = { "norg" },
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {
            config = {
              icons = {
                todo = {
                  undone = {
                    -- icon = "󰄱",
                    icon = " ",
                  },
                },
              },
            },
          },
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                neorg = "~/.neorg",
              },
              default_workspace = "neorg",
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = {
              extensions = "all",
            },
          },
        },
      })

      local cmp = require("cmp")
      cmp.setup.filetype("norg", {
        sources = cmp.config.sources({
          { name = "neorg" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        -- ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["<backspace>"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
