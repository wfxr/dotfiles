return {
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      opts.config.header = {
        [[                                                       ]],
        [[                                                       ]],
        [[                                  ,     ,              ]],
        [[                                  )\___/(              ]],
        [[                                 {(@)v(@)}             ]],
        [[                                  {|~~~|}              ]],
        [[                                  {/^^^\}              ]],
        [[                              -=-~'`m-m` .-^-_ wfxr    ]],
        [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
        [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
        [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
        [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
        [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
        [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
        [[                                                       ]],
        [[                                                       ]],
        [[                                                       ]],
      }
    end,
  },

  -- auto-resize windows
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    keys = { { "<C-w><C-w>", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
    config = function()
      vim.o.winwidth = 5
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        options = {
          icons_enabled = true,
          theme = "auto",
          disabled_filetypes = {},
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        globalstatus = true,
        sections = {
          lualine_a = { "mode" },
          lualine_b = { { "branch" }, { "diff" } },
          lualine_c = {
            {
              "filename",
              file_status = true,
              newfile_status = true,
              path = 3,
            },
          },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              -- symbols = global.symbols.diagnostic,
              diagnostics_color = {
                error = "DiagnosticSignError",
                warn = "DiagnosticSignWarn",
                info = "DiagnosticSignInfo",
                hint = "DiagnosticSignHint",
              },
              colored = true,
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
          },
          lualine_y = {
            {
              "filetype",
              "encoding",
            },
            {
              "fileformat",
              icons_enabled = true,
              symbols = {
                unix = "LF",
                dos = "CRLF",
                mac = "CR",
              },
            },
          },
          lualine_z = { "progress", "location" },
        },
        inactive_sections = {
          lualine_c = { "filename" },
          lualine_x = { "location" },
        },
        tabline = {
          lualine_a = {
            {
              "buffers",
              mode = 2,
              show_modified_status = true,
            },
          },
        },
        extensions = {
          "quickfix",
          "nvim-tree",
          "toggleterm",
          "fugitive",
        },
      }
    end,
  },

  "folke/twilight.nvim",
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "lewis6991/satellite.nvim",
    enabled = function()
      return vim.fn.has("nvim-0.10") == 1
    end,
  },

  {
    "luukvbaal/statuscol.nvim",
    -- event = "VeryLazy", -- will cause alpha screen flicker
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        setopt = true,
        ft_ignore = { "", "qf", "neo-tree", "alpha" },
        segments = {
          { text = { "%s" }, click = "v:lua.ScSa" },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { text = { " " } },
        },
      })
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = "kevinhwang91/promise-async",
    opts = {
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("   %d"):format(endLnum - lnum) --   ↙  
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth - 2
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        -- local rAlignAppndx =
        -- math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
        -- suffix = (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "Folded" }) -- Folded / MoreMsg
        return newVirtText
      end,
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "▏",
        tab_char = "▏",
      },
    },
  },

  {
    "echasnovski/mini.indentscope",
    enabled = false,
    opts = {
      symbol = "▏",
    },
  },
}
