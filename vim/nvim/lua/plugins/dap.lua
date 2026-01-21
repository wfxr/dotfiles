local dap = setmetatable({}, {
  __index = function(_, key)
    return function(...)
      local dap = require("dap")
      return dap[key](...)
    end
  end,
})

local neotest = {}

function neotest.dap_test()
  require("neotest").run.run({ strategy = "dap" })
end

local function pick_test_from_current_file()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local tests = {}
  for _, line in ipairs(lines) do
    local name = line:match("^func%s+(Test[%w_]+)%s*%(%s*[%w_]+%s+%*testing%.T")
    if name then
      tests[#tests + 1] = name
    end
  end
  if #tests == 0 then
    vim.notify("No TestXxx(t *testing.T) found in " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.WARN)
    return nil
  end
  local co = coroutine.running()
  vim.ui.select(tests, { prompt = "Select Go test (current file):" }, function(choice)
    coroutine.resume(co, choice)
  end)
  return coroutine.yield()
end

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<F6>", neotest.dap_test, desc = "Debug current test" },
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
      { "<F4>",       dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
      { "<F5>",       dap.continue,          desc = "Run/Continue"      },
      { "<F8>",       dap.run_last,          desc = "Run Last"          },

      { "<F9>",       dap.terminate,         desc = "Terminate"         },
      { "<F11>",      dap.up,                desc = "Up"                },
      { "<F12>",      dap.down,              desc = "Down"              },

      { "<Up>",       dap.run_to_cursor,     desc = "Run to Cursor"     },
      { "<Down>",     dap.step_over,         desc = "Step Over"         },
      { "<Right>",    dap.step_into,         desc = "Step Into"         },
      { "<Left>",     dap.step_out,          desc = "Step Out"          },
			{ "<leader>dd", dap.disconnect,        desc = "Disconnect"    },
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
        -- Optional: prompt for the program executable so symbols can be loaded properly
        -- program = function()
        --   return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        -- end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      })

      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Debug Test (pick from file)",
            request = "launch",
            mode = "test",
            program = "${fileDirname}",
            cwd = "${fileDirname}",
            args = function()
              local testname = pick_test_from_current_file()
              if not testname then
                return { "-test.run", "^$", "-test.count=1" } -- 取消时不跑任何测试
              end
              return { "-test.run", "^" .. testname .. "$", "-test.count=1" }
            end,
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
