local ok, fidget = pcall(require, "fidget")
if not ok then
    return
end

fidget.setup {
    window = {
        done = '',
        spinner = 'meter',
        relative = "editor",
        blend = 90,
    },
}
