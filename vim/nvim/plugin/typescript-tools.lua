local ok, ts_tools = pcall(require, "typescript-tools")
if not ok then
    return
end

ts_tools.setup {
    settings = {
        tsserver_plugins = { "@styled/typescript-styled-plugin" },
        tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        },
    },
}
