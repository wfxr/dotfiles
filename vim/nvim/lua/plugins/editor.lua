return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      -- stylua: ignore start
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        changedelete = { text = '┃' },
        untracked    = { text = '┃' },
        topdelete    = { text = '⎺' }, -- ⎺ ↗
        delete       = { text = '⎽' }, -- ⎽ ↘
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false, -- Replaced by folke's snacks explorer
    keys = {
      { "<c-n>", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
    },
    opts = {
      popup_border_style = "rounded",
      window = {
        width = 30,
        side = "left",
        mappings = {
          ["<c-x>"] = "open_split",
          ["<c-v>"] = "open_vsplit",
        },
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
    "nvim-mini/mini.align",
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
    -- stylua: ignore start
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "o", "x" }, false },
      { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "gS", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
    opts = {
      label = {
        before = true,
        after = false,
      },
      modes = {
        search = {
          enabled = false,
        },
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    opts = {
      signs = false,
      keywords = {
        FIX = {
          icon = " ",
          color = "error",
          alt = { "FIXME", "FIXIT", "BUG", "ISSUE", "DEBUG" },
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "hint", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        SAFETY = { icon = "󰌾 ", color = "info", alt = { "SECURITY", "SECURE" } },
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    enabled = not vim.env.SSH_CLIENT and vim.fn.filereadable("/.dockerenv") == 0,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

  {
    "toppair/peek.nvim",
    ft = { "markdown" },
    build = "deno task --quiet build:fast",
    enabled = false and (not vim.env.SSH_CLIENT and vim.fn.filereadable("/.dockerenv") == 0),
    keys = {
      {
        "<leader>cp",
        function()
          require("peek").open()
        end,
        desc = "Markdown Preview",
      },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        width = "block",
        position = "left",
        right_pad = 1,
        left_pad = 1,
      },
    },
  },

  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"

      vim.g.vimtex_compiler_latexmk = {
        build_dir = "",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        options = {
          "-xelatex", -- Use XeLaTeX (for Unicode and modern font support)
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }

      vim.g.vimtex_view_automatic = 1
      vim.g.vimtex_view_forward_search_on_start = 1

      vim.g.vimtex_quickfix_mode = 2
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull",
        "Overfull",
        "specifier changed to",
      }

      vim.g.vimtex_compiler_progname = "nvim"
      vim.g.vimtex_fold_enabled = 0
    end,
  },
}
