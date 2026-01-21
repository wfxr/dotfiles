return {
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_buf, win)
            return vim.w[win].snacks_win
              and vim.w[win].snacks_win.position == pos
              and vim.w[win].snacks_win.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
    end,
  },

  {
    "folke/trouble.nvim",
    optional = true,
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          },
        })
      end,
    },
  },

  -- auto-resize windows
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      { "anuvyklack/middleclass" },
      { "anuvyklack/animation.nvim", enabled = false },
    },
    keys = { { "<a-m>", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
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
      local get_color = require("lualine.utils.utils").extract_highlight_colors
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
              diagnostics_color = {
                error = { fg = get_color("DiagnosticError", "fg") },
                warn = { fg = get_color("DiagnosticWarn", "fg") },
                info = { fg = get_color("DiagnosticInfo", "fg") },
                hint = { fg = get_color("DiagnosticHint", "fg") },
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

  {
    "lewis6991/satellite.nvim",
    enabled = function()
      return vim.fn.has("nvim-0.10") == 1
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
    "wfxr/smartcolumn.nvim",
    dev = true,
    opts = {
      colorcolumn = 100,
      custom = {
        c = 80,
        cpp = 80,
        gitcommit = 72,
      },
    },
  },
}
