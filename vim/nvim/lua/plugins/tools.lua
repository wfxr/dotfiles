---@diagnostic disable: missing-fields

return {
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
    event = "VeryLazy",
  },

  {
    "nvim-neorg/neorg",
    enabled = false,
    cmd = { "Neorg" },
    ft = { "norg" },
    dependencies = {
      {
        "vhyrro/luarocks.nvim",
        priority = 1000, -- We'd like this plugin to load first out of the rest
        config = true, -- This automatically runs `require("luarocks-nvim").setup()`
      },
    },
    version = "*",
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
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = {
              extensions = "all",
            },
          },
        },
      })
    end,
  },
}
