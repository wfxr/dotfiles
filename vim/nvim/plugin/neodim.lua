local ok, neodim = pcall(require, "neodim")
if not ok then
    return
end

neodim.setup {
    alpha = 0.6,
    hide = {
        virtual_text = false,
        signs = true,
        underline = false,
    },
}
