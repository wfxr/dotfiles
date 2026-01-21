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
            -- Keep close/cancel behavior consistent with other snacks pickers.
            i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
            i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
          },
        },
      },
      -- Replace netrw since we're standardizing on snacks for file browsing.
      explorer = { replace_netrw = true },
      gh = { enabled = true },
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
      scroll = {
        animate = {
          duration = { step = 15, total = 150 },
          easing = "linear",
        },
        animate_repeat = {
          delay = 100,
          duration = { step = 5, total = 50 },
          easing = "linear",
        },
        -- what buffers to animate
        filter = function(buf)
          return vim.g.snacks_scroll ~= false
            and vim.b[buf].snacks_scroll ~= false
            and vim.bo[buf].buftype ~= "terminal"
        end,
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
          gh_issue = {},
          gh_pr = {},
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
      { "<leader>-",       function() Snacks.explorer.reveal() end, desc = "File Explorer (current file)" },
      { "<leader>gd",      function() Snacks.picker.git_diff({ group = true }) end, desc = "Git Diff" },
      { "<leader>gi",      function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      { "<leader>gp",      function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      { "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
      -- stylua: ignore end
    },
  },
}
