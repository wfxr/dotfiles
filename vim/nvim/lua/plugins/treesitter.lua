return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "cmake",
        "c",
        "cpp",
        "go",
        "rust",
        "bash",
        "css",
        "devicetree",
        "gitcommit",
        "gitignore",
        "glsl",
        "graphql",
        "http",
        "meson",
        "ninja",
        "nix",
        "sql",
        "dockerfile",
        -- "comment", -- comments are slowing down TS bigtime, so disable for now
      })
    end,
  },
}
