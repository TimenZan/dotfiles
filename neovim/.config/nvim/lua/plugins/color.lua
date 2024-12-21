local plugs = {}

table.insert(plugs, {
    'norcalli/nvim-colorizer.lua',
    main = 'colorizer',
    opts = {},
    event = 'VeryLazy',
})

table.insert(plugs, {
    'hiphish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
})

table.insert(plugs, { 'EdenEast/nightfox.nvim', priority = 1000, })
table.insert(plugs, { 'aktersnurra/no-clown-fiesta.nvim', priority = 1000, })
table.insert(plugs, { 'folke/tokyonight.nvim', priority = 1000, })
table.insert(plugs, { 'morhetz/gruvbox', priority = 1000, })
table.insert(plugs, { 'ray-x/starry.nvim', priority = 1000, })

table.insert(plugs, {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function ()
        require 'catppuccin'.setup {
            dim_inactive = {
                enabled = true,
            },
            integrations = {
                blink_cmp = true,
                fidget = true,
                neotest = true,
                lsp_trouble = true,
                sandwich = true,
            },
        }
        vim.cmd.colorscheme 'catppuccin-mocha'
    end,
})

return plugs
