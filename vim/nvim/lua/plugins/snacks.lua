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
          pick = nil,
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
    },
    keys = {
      -- stylua: ignore start
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<c-\\>",     function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<c-\\>",     function() Snacks.terminal() end, desc = "which_key_ignore", mode = {"t"} },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      -- stylua: ignore end
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
  },
}
