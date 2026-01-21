-- Set keymap for buffers with a specific LSP client
Snacks.keymap.set("n", "K", function()
  vim.cmd.RustLsp({ "hover", "actions" })
end, {
  lsp = { name = "rust-analyzer" },
  desc = "Rust Hover Actions",
})
