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
    -- Override the LazyVim markdown extra to disable browser preview in SSH/container.
    "iamcco/markdown-preview.nvim",
    enabled = not vim.env.SSH_CLIENT and vim.fn.filereadable("/.dockerenv") == 0,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- Extend the LazyVim markdown extra: render in Avante buffers too.
    ft = { "markdown", "norg", "rmd", "org", "codecompanion", "Avante" },
    opts = function(_, opts)
      opts = opts or {}
      opts.file_types = opts.file_types or { "markdown", "norg", "rmd", "org", "codecompanion" }
      if not vim.tbl_contains(opts.file_types, "Avante") then
        table.insert(opts.file_types, "Avante")
      end
      opts.code = vim.tbl_deep_extend("force", opts.code or {}, {
        width = "block",
        position = "left",
        right_pad = 1,
        left_pad = 1,
      })
      return opts
    end,
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
