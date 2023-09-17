local ok, Comment = pcall(require,"Comment")
if not ok then
    return
end

Comment.setup()

vim.cmd [[
    nmap <c-_> gccj
    vmap <c-_> gcj
]]
