local ok, leap = pcall(require, "leap")
if not ok then
    return
end

leap.setup {
    case_sensitive = true,
}
leap.set_default_keymaps()
