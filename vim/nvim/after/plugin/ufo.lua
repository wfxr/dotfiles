local ok, ufo = pcall(require, "ufo")
if not ok then
    return
end

local function fold_virt_text_handler(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ("  %d"):format(endLnum - lnum) --  ↙  
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    local rAlignAppndx =
    math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
    suffix = (" "):rep(rAlignAppndx) .. suffix
    table.insert(newVirtText, { suffix, "Folded" }) -- Folded / MoreMsg
    return newVirtText
end

vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)

ufo.setup {
    fold_virt_text_handler = fold_virt_text_handler,
}
