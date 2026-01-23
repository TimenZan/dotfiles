local M = {}

--- @class util.scandir.opts
--- @inlinedoc
---
--- What types to return
--- (default: `'file'`)
--- @field types? uv.aliases.fs_types | uv.aliases.fs_types[]
---
--- Filter the names
--- (default: `return true`)
--- @field filter? fun(name: string): boolean

-- TODO: add depth and other options to pass through to `fs.dir`?

--- Returns the contents of a given directory
--- @param directory string
--- @param opts? util.scandir.opts
--- @return table
local function scandir(directory, opts)
    -- normalize options
    opts = opts or {}
    local tmptypes = opts.types or { 'file' }
    local tys = (type(tmptypes) == 'table') and tmptypes or { tmptypes }
    local types = M.to_set(tys)

    local filter = opts.filter or function (_) return true end
    local t = {}
    for name, ty in vim.fs.dir(directory, {}) do
        if types[ty] and filter(name) then
            table.insert(t, name)
        end
    end
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
M.iterate_dir = function (cur, directory)
    local res = {}
    local fnames = scandir(directory, { filter = is_lua })
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

--- Modify all specs to be loaded on `VeryLazy` if they don't already specify an event
--- @param plugs table the specifications to modify
--- @return table
M.all_verylazy = function (plugs)
    return vim.tbl_map(
        function (e)
            if type(e) == 'string' then
                e = { e }
            end
            e.event = e.event or { 'VeryLazy', }
            return e
        end,
        plugs)
end


--- Convert a list-like table to a set
---
--- @generic T
--- @param t T[]
--- @return table<T, boolean> set
function M.to_set(t)
    local set = {}
    for _, v in ipairs(t) do
        set[v] = true
    end
    return set
end

--- Convert a table into a set.
--- Includes non-integer keys
---
--- @generic T
--- @param t table<any, T>
--- @return table<T, boolean> set
function M.to_set_all(t)
    local set = {}
    for _, v in pairs(t) do
        set[v] = true
    end
    return set
end

-- TODO: do we want to return the result?
-- @return table<T, boolean> set

--- Add all i_elements of a table to a set
---
--- @generic T
--- @param set table<T, boolean>
--- @param t T|T[]
function M.set_add(set, t)
    if type(t) == 'table' then
        for _, v in ipairs(t) do
            set[v] = true
        end
    else
        set[t] = true
    end
end

return M
