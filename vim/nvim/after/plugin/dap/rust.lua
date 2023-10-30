local ok, dap = pcall(require, "dap")
if not ok then
    return
end

dap.configurations.rust = {
    {
        name = "Attach",
        type = "rt_lldb",
        request = "attach",
        pid = require("dap.utils").pick_process,
        stopOnEntry = true,
        waitFor = false,
    },
    {
        name = "Launch",
        type = "rt_lldb",
        request = "launch",
        program = function()
            -- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            return vim.fn.jobstart('cargo build')
        end,
        stopOnEntry = true,
        waitFor = false,
    },
}
