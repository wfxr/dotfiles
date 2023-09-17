local ok, bqf = pcall(require, "bqf")
if not ok then
    return
end

bqf.setup {
    preview = {
        win_height = 5,
        win_vheight = 5,
    },
}
