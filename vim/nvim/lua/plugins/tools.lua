return {
  { "pwntester/octo.nvim", opts = {}, cmd = "Octo" },

  -- better diffing
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {},
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },

  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPTActAs", "ChatGPT" },
    opts = {},
  },

  {
    "ojroques/nvim-osc52",
    config = function()
      vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
      vim.keymap.set("n", "<c-y>", "<leader>y_", { remap = true })
      vim.keymap.set("x", "<c-y>", require("osc52").copy_visual)
    end,
  },

  {
    "tpope/vim-fugitive",
    Event = "VeryLazy",
  },

  {
    "NvChad/nvim-colorizer.lua",
    ft = { "vim", "lua", "tmux", "zsh", "html", "css", "sass", "typescript", "javascript" },
    config = function()
      require("colorizer").setup({})
    end,
  },
}
