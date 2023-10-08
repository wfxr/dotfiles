local ok, ibl = pcall(require, "ibl")
if not ok then
    return
end

ibl.overwrite {
    indent = { char = "▏" },
}
