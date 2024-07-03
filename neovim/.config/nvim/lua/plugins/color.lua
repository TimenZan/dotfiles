local plugs = {}

table.insert(plugs, {
    'norcalli/nvim-colorizer.lua',
    main = 'colorizer',
    opts = {},
})

table.insert(plugs, {
    'hiphish/rainbow-delimiters.nvim',
})

table.insert(plugs, { 'EdenEast/nightfox.nvim', priority = 1000, })
table.insert(plugs, { 'aktersnurra/no-clown-fiesta.nvim', priority = 1000, })
table.insert(plugs, { 'folke/tokyonight.nvim', priority = 1000, })
table.insert(plugs, { 'morhetz/gruvbox', priority = 1000, })
table.insert(plugs, { 'ray-x/starry.nvim', priority = 1000, })

table.insert(plugs, {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function() vim.cmd.colorscheme 'catppuccin-mocha' end,
})

return plugs
