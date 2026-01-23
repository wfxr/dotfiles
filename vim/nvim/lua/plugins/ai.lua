---@diagnostic disable: undefined-doc-name, missing-fields

return {
  {
    "folke/sidekick.nvim",
    keys = {
      {
        "<m-.>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
    },
    opts = {
      cli = {
        mux = {
          enabled = true,
          backend = "tmux",
        },
        tools = {
          debug = {
            cmd = { "bash", "-c", "env | sort | bat -l env" },
          },
        },
      },
    },
  },
}
