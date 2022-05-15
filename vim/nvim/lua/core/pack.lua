local fn, uv, api = vim.fn, vim.loop, vim.api
local vim_path = require("core.global").vim_path
local data_dir = require("core.global").data_dir
local modules_dir = vim_path .. "/lua/modules"
local packer_compiled = data_dir .. "lua/_compiled.lua"
local bak_compiled = data_dir .. "lua/bak_compiled.lua"
local packer = nil

local Packer = {}
Packer.__index = Packer

function Packer:load_plugins()
    self.repos = {}

    local get_plugins_list = function()
        local list = {}
        local tmp = vim.split(fn.globpath(modules_dir, "*/plugins.lua"), "\n")
        for _, f in ipairs(tmp) do
            list[#list + 1] = f:sub(#modules_dir - 6, -1)
        end
        return list
    end

    local plugins_file = get_plugins_list()
    for _, m in ipairs(plugins_file) do
        local repos = require(m:sub(0, #m - 4))
        for repo, conf in pairs(repos) do
            self.repos[#self.repos + 1] = vim.tbl_extend("force", { repo }, conf)
        end
    end
end

function Packer:load_packer()
    if not packer then
        api.nvim_command("packadd packer.nvim")
        packer = require("packer")
    end
    packer.init({
        ensure_dependencies = true,
        compile_path = packer_compiled,
        disable_commands = true,
        -- max_jobs = 16, -- https://github.com/wbthomason/packer.nvim/issues/751
        compile_on_sync = true,
        auto_clean = true,
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
    })
    packer.reset()
    local use = packer.use
    self:load_plugins()
    use({ "wbthomason/packer.nvim" })
    for _, repo in ipairs(self.repos) do
        use(repo)
    end
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        if not packer then
            Packer:load_packer()
        end
        return packer[key]
    end,
})

function plugins.back_compile()
    if vim.fn.filereadable(packer_compiled) == 1 then
        os.rename(packer_compiled, bak_compiled)
    end
    plugins.compile()
end

function plugins.auto_compile()
    local file = vim.fn.expand("%:p")
    if file:match(modules_dir) then
        plugins.clean()
        plugins.back_compile()
    end
end

function plugins.load_compile()
    if vim.fn.filereadable(packer_compiled) == 1 then
        require("_compiled")
    else
        assert("Missing packer compile file Run PackerCompile Or PackerInstall to fix")
    end
    vim.cmd([[command! PackerCompile lua require('core.pack').back_compile()]])
    vim.cmd([[command! PackerInstall lua require('core.pack').install()]])
    vim.cmd([[command! PackerUpdate lua require('core.pack').update()]])
    vim.cmd([[command! PackerSync lua require('core.pack').sync()]])
    vim.cmd([[command! PackerClean lua require('core.pack').clean()]])
    vim.cmd([[autocmd User PackerComplete lua require('core.pack').back_compile()]])
    vim.cmd([[command! PackerStatus lua require('core.pack').compile() require('packer').status()]])
end

return plugins
