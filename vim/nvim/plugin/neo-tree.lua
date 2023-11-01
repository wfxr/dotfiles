local ok, neotree = pcall(require, "neo-tree")
if not ok then
    return
end

neotree.setup ({
    default_component_configs = {
        git_status = {
            symbols = {
                added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                conflict  = "",
                unstaged  = "",
                staged    = "",
                renamed   = "",
                untracked = "󰄱", --  󰄱
                deleted   = "",
                ignored   = "",
            }
        },
    },
})
