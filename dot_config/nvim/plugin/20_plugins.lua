---@class Plugin : vim.pack.Spec
---@field setup function?

---@type Plugin[]
local plugins = require('plugins')

vim.pack.add(plugins, { load = true, confirm = false })

for _, plugin in ipairs(plugins) do
    if plugin.setup ~= nil then
        plugin.setup()
    end
end
