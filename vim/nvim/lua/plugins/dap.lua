local cfg = require("config.dap")

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "fredrikaverpil/neotest-golang",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<F6>", cfg.neotest_dap_test, desc = "Debug current test" },
    },
    opts = {
      testify_enabled = true,
      adapters = {
        require("rustaceanvim.neotest"),
        require("neotest-golang")({
          testify_enabled = true,
        }),
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "wfxr/nvim-dap-go", -- FIXME: https://github.com/leoluz/nvim-dap-go/issues/124
    },
    keys = {
      -- stylua: ignore start
      { "<F4>",       cfg.dap("toggle_breakpoint"), desc = "Toggle Breakpoint" },
      { "<F5>",       cfg.dap("continue"),          desc = "Run/Continue"      },
      { "<F8>",       cfg.dap("run_last"),          desc = "Run Last"          },

      { "<F9>",       cfg.dap("terminate"),         desc = "Terminate"         },
      { "<F11>",      cfg.dap("up"),                desc = "Up"                },
      { "<F12>",      cfg.dap("down"),              desc = "Down"              },

      { "<Up>",       cfg.dap("run_to_cursor"),     desc = "Run to Cursor"     },
      { "<Down>",     cfg.dap("step_over"),         desc = "Step Over"         },
      { "<Right>",    cfg.dap("step_into"),         desc = "Step Into"         },
      { "<Left>",     cfg.dap("step_out"),          desc = "Step Out"          },
      { "<leader>dd", cfg.dap("disconnect"),        desc = "Disconnect"        },
      -- stylua: ignore end
    },
    init = function()
      local dap = require("dap")
      dap.configurations.rust = dap.configurations.rust or {}

      table.insert(dap.configurations.rust, {
        name = "LLDB: Attach (pick)",
        type = "codelldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      })

      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Debug Test (current position)",
            request = "launch",
            mode = "test",
            program = "${fileDirname}",
            cwd = "${fileDirname}",
            args = cfg.go_test_args,
          },
          {
            type = "go",
            name = "Debug Test [TiDB] (current position)",
            request = "launch",
            mode = "test",
            program = "${fileDirname}",
            cwd = "${fileDirname}",
            args = cfg.go_test_args,
            buildFlags = "-tags=intest",
          },
        },
      })
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    keys = {
      {
        "<F3>",
        function()
          require("nvim-dap-virtual-text").toggle()
        end,
        desc = "Toggle Dap Virtual Text",
      },
    },
    opts = {
      enabled = false,
    },
  },
}
