local M = {}

--- Returns all filenames in a given directory
--- @param directory string
--- @return table
local function scandir(directory)
    local t = {}
    local pfile = io.popen('ls -a "' .. directory .. '"')
    if not pfile then return {} end
    for filename in pfile:lines() do
        table.insert(t, filename)
    end
    pfile:close()
    return t
end

--- @param filename string
--- @return boolean
local function is_lua(filename)
    return string.match(filename, "[.]lua$")
end

--- Require all files in `directory`, combining the returned tables
---
--- ```lua
--- local cur_dir = string.match(debug.getinfo(1, 'S').source, '^@(.*)/')
--- local servers = util.iterate_dir('plugins.lsp_servers', cur_dir .. '/lsp_servers')
--- ```
--- @param cur string the current module
--- @param directory string the directory to consume
--- @return table any combined table of all required files
M.iterate_dir = function(cur, directory)
    local res = {}
    local fnames = vim.tbl_filter(is_lua, scandir(directory))
    for _, filename in ipairs(fnames) do
        -- Strip the ".lua" suffix from the filename
        local config_module = string.match(filename, "(.+).lua$")
        -- Add the keys to the running table, faulting on duplicate keys
        local infos = require(cur .. '.' .. config_module)
        for _, server_config in ipairs(infos) do
            res = vim.tbl_deep_extend("error", res, server_config)
        end
    end
    return res
end

return M
