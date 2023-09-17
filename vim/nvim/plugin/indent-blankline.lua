local ok, indent_blankline = pcall(require, "indent_blankline")
if not ok then
    return
end

indent_blankline.setup {
    char = "▏",
    filetype = {
        "c",
        "cpp",
        "go",
        "lua",
        "java",
        "kotlin",
        "scala",
        "clojure",
        "rust",
        "sh",
        "zsh",
        "vim",
        "ruby",
        "python",
        "make",
        "toml",
        "yaml",
    },
    use_treesitter_scope = true,
    show_current_context = false,
    show_current_context_start = false,
    show_trailing_blankline_indent = false,
    space_char_blankline = " ",
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = { "help", "packer" },
}
