local ok, lspkind = pcall(require, "lspkind")
if not ok then
    return
end

lspkind.init()
