local plugs = {}

-- table.insert(plugs, {
--     'alx741/vim-stylishask',
-- })

table.insert(plugs, {
    'mrcjkb/haskell-tools.nvim',
    lazy = false,
    config = function ()
        vim.g.haskell_tools = {
            hls = {
                settings = {
                    formattingProvider = "floskell",
                },
            },
        }
    end,
})

table.insert(plugs, {
    'mrcjkb/haskell-snippets.nvim',
    ft = { 'haskell' },
    config = function ()
        require 'luasnip'.add_snippets('haskell', require 'haskell-snippets'.all, { key = 'haskell' })
    end,
})

return plugs
