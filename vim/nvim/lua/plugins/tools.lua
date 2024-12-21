---@diagnostic disable: missing-fields

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

  {
    "ibhagwan/fzf-lua",
    opts = function(_, _opts)
      local config = require("fzf-lua.config")
      config.defaults.keymap.fzf["alt-d"] = "preview-half-page-down"
      config.defaults.keymap.fzf["alt-u"] = "preview-half-page-up"
      config.defaults.keymap.builtin["<a-d>"] = "preview-half-page-down"
      config.defaults.keymap.builtin["<a-u>"] = "preview-half-page-up"
      config.defaults.keymap.builtin["<a-j>"] = "preview-down"
      config.defaults.keymap.builtin["<a-k>"] = "preview-up"
      config.defaults.keymap.builtin["<a-w>"] = "toggle-preview-wrap"
      config.defaults.keymap.builtin["?"] = "toggle-preview"
    end,
  },

  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        desc = "Open yazi at the current file",
        "<leader>-",
        "<cmd>Yazi<cr>",
      },
      {
        desc = "Open the file manager in nvim's working directory",
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
      },
      {
        desc = "Resume the last yazi session",
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
      },
    },
    opts = {
      -- replace netrw with yazi
      open_for_directories = true,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}
