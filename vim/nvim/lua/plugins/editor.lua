return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      -- stylua: ignore start
      signs = {
        add          = { hl = 'GitSignsAdd',    text = '┃' },
        change       = { hl = 'GitSignsChange', text = '┃' },
        changedelete = { hl = 'GitSignsChange', text = '┃' },
        untracked    = { hl = 'GitSignsAdd',    text = '┃' },
        topdelete    = { hl = 'GitSignsDelete', text = '⎺' }, -- ⎺ ↗
        delete       = { hl = 'GitSignsDelete', text = '⎽' }, -- ⎽ ↘
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<c-n>", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
    },
    opts = {
      popup_border_style = "rounded",
      window = {
        width = 30,
        side = "left",
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- stylua: ignore start
            added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "", -- this can only be used in the git_status source
            renamed   = "", -- this can only be used in the git_status source
            conflict  = "",
            unstaged  = "",
            staged    = "",
            untracked = "󰄱", --  󰄱
            ignored   = "",
          },
        },
      },
    },
  },

  {
    "echasnovski/mini.align",
    opts = {
      mappings = {
        start = "ga",
        start_with_preview = "gA",
      },
    },
  },

  -- Readline key bindings
  {
    "tpope/vim-rsi",
  },

  {
    "folke/flash.nvim",
    opts = {
      label = {
        before = true,
        after = false,
      },
    },
  },

  {
    "karb94/neoscroll.nvim",
    opts = {
      mappings = { "<C-u>", "<C-d>", "zt", "zz", "zb" },
    },
  },

  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "FIXIT", "BUG", "ISSUE", "DEBUG" },
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "hint", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
  },
}
