local ok, spaceless = pcall(require, "spaceless")
if not ok then
    return
end

spaceless.setup()

-- Strip trailing whitespaces
vim.cmd [[
    function! s:strip_whitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
    command! StripWhitespace call s:strip_whitespace()
]]
