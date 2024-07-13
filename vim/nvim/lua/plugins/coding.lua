return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  -- better increase/descrease
  {
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
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "andersevenrud/cmp-tmux",
      "lukas-reineke/cmp-rg",
      "onsails/lspkind.nvim",
      "petertriho/cmp-git",
      "saadparwaiz1/cmp_luasnip",
      "zbirenbaum/copilot-cmp",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local mapping = cmp.mapping
      local luasnip = require("luasnip")
      opts.experimental.ghost_text = false
      return vim.tbl_extend("force", opts, {
        formatting = {
          fields = { "abbr", "kind" },
          format = function(_, item)
            local max_abbr_width = 40
            local ellipsis_char = ".."

            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            if #item.abbr > max_abbr_width then
              item.abbr = item.abbr:sub(1, max_abbr_width - ellipsis_char:len()) .. ellipsis_char
            end
            item.menu = nil
            return item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = mapping(mapping.scroll_docs(4), { "i" }),
          ["<C-u>"] = mapping(mapping.scroll_docs(-4), { "i" }),
          ["<Tab>"] = mapping.confirm({ select = true }),
          ["<C-n>"] = mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-p>"] = mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-j>"] = mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          ["<C-k>"] = mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-g>"] = mapping(function(fallback)
            cmp.abort()
          end, { "i", "c" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
          { name = "copilot" },
          { name = "tmux" },
          { name = "rg" },
        }),
      })
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      local cmp_git = require("cmp_git")

      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      cmp.setup(opts)

      cmp_git.setup({
        enableRemoteUrlRewrites = true,
      })

      cmp.setup.filetype("gitcommit", {
        sources = {
          { name = "git" },
          { name = "buffer" },
        },
      })
    end,
  },

  {
    "Wansmer/treesj",
    keys = {
      { "gJ", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>ssr",
        function()
          require("ssr").open()
        end,
        mode = { "n", "x" },
        desc = "Structural Replace",
      },
    },
  },

  {
    "gbprod/yanky.nvim",
    keys = {
      -- stylua: ignore start
      { "<leader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
      { "p", "<Plug>(YankyPutAfter)",    mode = { "n" }, desc = "Put yanked text after cursor" },
      { "p", "<Plug>(YankyPutAfter)gvy", mode = { "x" }, desc = "Put yanked text after cursor (keep clipboard)" },
      { "gp", "`[v`]", desc = "Select last paste" },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
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
        "<C-e>",
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
    "echasnovski/mini.surround",
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

  {
    "L3MON4D3/LuaSnip",
    keys = {
      { "<tab>", mode = { "i", "s" }, false },
      { "<s-tab>", mode = { "i", "s" }, false },
    },
    config = function(_, opts)
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/snippets/luasnip" } })
    end,
  },

  -- {
  --   "echasnovski/mini.bracketed",
  --   event = "BufReadPost",
  --   enabled = false,
  --   config = function()
  --     local bracketed = require("mini.bracketed")
  --     bracketed.setup({
  --       file = { suffix = "" },
  --       window = { suffix = "" },
  --       quickfix = { suffix = "" },
  --       yank = { suffix = "" },
  --       treesitter = { suffix = "n" },
  --     })
  --   end,
  -- },

  -- {
  --   "github/copilot.vim",
  --   event = "InsertEnter",
  --   config = function()
  --     vim.g.copilot_filetypes = {
  --       ["*"] = true,
  --       DressingInput = false,
  --       TelescopePrompt = false,
  --       ["neo-tree-popup"] = false,
  --       ["dap-repl"] = false,
  --     }
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_assume_mapped = true
  --
  --     local function accept_word()
  --       vim.fn["copilot#Accept"]("")
  --       local suggestion = vim.fn["copilot#TextQueuedForInsertion"]()
  --       if suggestion == "" then
  --         local forward_word = vim.api.nvim_replace_termcodes("<S-Right>", true, false, true)
  --         vim.api.nvim_feedkeys(forward_word, "i", true)
  --       else
  --         suggestion = vim.fn.split(suggestion, [[\W\+\zs]])[1]
  --         suggestion = vim.fn.split(suggestion, [[\n\zs]])[1]
  --         return suggestion
  --       end
  --     end
  --
  --     vim.keymap.set("i", "<C-e>", "copilot#Accept('<End>')", {
  --       noremap = true,
  --       silent = true,
  --       script = true,
  --       expr = true,
  --       replace_keycodes = false,
  --       desc = "Copilot accept all",
  --     })
  --     -- stylua : ignore start
  --     vim.keymap.set("i", "<M-f>", accept_word, {
  --       noremap = true,
  --       silent = true,
  --       expr = true,
  --       desc = "Copilot accept word",
  --     })
  --     vim.keymap.set("i", "<M-n>", "<Plug>(copilot-next)", { desc = "Copilot next suggestion" })
  --     vim.keymap.set("i", "<M-p>", "<Plug>(copilot-previous)", { desc = "Copilot previous suggestion" })
  --   end,
  -- },
}
