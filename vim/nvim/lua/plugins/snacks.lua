---@diagnostic disable: missing-fields

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      input = {
        enabled = true,
        win = {
          keys = {
            i_del_word = { "<C-w>", "<cmd>normal! diw<cr><right>", mode = "i", expr = true },
            i_esc = { "<Esc>", "close", mode = "i", expr = true },
          },
        },
      },
      gitbrowse = { enabled = true },
      dim = {
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          easing = "outQuad",
          duration = {
            step = 15, -- ms per step
            total = 150, -- maximum duration
          },
        },
      },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
                                                       
                                                       
                                  ,     ,              
                                  )\___/(              
                                 {(@)v(@)}             
                                  {|~~~|}              
                                  {/^^^\}              
                              -=-~'`m-m` .-^-_ wfxr    
 ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
 ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
 ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
 ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
 ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
 ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
                                                       
                                                       
                                                       ]],
        },
      },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
      terminal = {
        win = {
          position = "float",
        },
      },
      indent = {
        enabled = true,
        indent = {
          enabled = true,
          char = "▏",
        },
        scope = {
          enabled = true, -- enable highlighting the current scope
          char = "▏",
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = "SnacksIndent1", ---@type string|string[] hl group for scopes
        },
        animate = {
          style = "out",
          easing = "linear",
          duration = {
            step = 15, -- ms per step
            total = 150, -- maximum duration
          },
        },
        scroll = {
          animate = {
            duration = { step = 15, total = 150 },
            easing = "linear",
          },
          spamming = 10, -- threshold for spamming detection
          -- what buffers to animate
          filter = function(buf)
            return vim.g.snacks_scroll ~= false
              and vim.b[buf].snacks_scroll ~= false
              and vim.bo[buf].buftype ~= "terminal"
          end,
        },
        -- filter for buffers to enable indent guides
        filter = function(buf)
          local excluded_filetypes = {
            markdown = true,
            diff = true,
            text = true,
          }
          local b = vim.b[buf]
          local bo = vim.bo[buf]
          return vim.g.snacks_indent ~= false
            and b.snacks_indent ~= false
            and bo.buftype == ""
            and not excluded_filetypes[bo.filetype]
        end,
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<a-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<a-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
            },
          },
        },
        sources = {
          explorer = {
            win = {
              list = {
                keys = {
                  ["<c-c>"] = false,
                  ["<c-n>"] = false,
                  ["<c-p>"] = false,
                },
              },
            },
          },
        },
      },
    },
    keys = {
      -- stylua: ignore start
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Open" },
      { "<c-\\>",          function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<c-\\>",          function() Snacks.terminal() end, desc = "which_key_ignore", mode = {"t"} },
      { "]]",              function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",              function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      { "<c-n>",           function() Snacks.explorer({ cwd = LazyVim.root() }) end, desc = "File Explorer (root dir)" },
      -- stylua: ignore end
    },
  },
}
