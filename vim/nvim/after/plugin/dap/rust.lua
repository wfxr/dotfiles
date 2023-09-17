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
}
