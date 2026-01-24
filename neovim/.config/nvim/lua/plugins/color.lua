local plugs = {}

table.insert(plugs, {
    'norcalli/nvim-colorizer.lua',
    main = 'colorizer',
    opts = {},
    event = 'VeryLazy',
})

table.insert(plugs, {
    'hiphish/rainbow-delimiters.nvim',
    opts = {
        strategy = {
            [''] = 'rainbow-delimiters.strategy.global',
            vim = 'rainbow-delimiters.strategy.local',
        },
        query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
        },
        priority = {
            [''] = 110,
            lua = 210,
        },
        highlight = {
            'RainbowDelimiterRed',
            'RainbowDelimiterYellow',
            'RainbowDelimiterBlue',
            'RainbowDelimiterOrange',
            'RainbowDelimiterGreen',
            'RainbowDelimiterViolet',
            'RainbowDelimiterCyan',
        },
    },
    main = 'rainbow-delimiters.setup',
    lazy = false,
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
                colorful_winsep = {
                    enabled = true,
                },
            },
        }
        vim.cmd.colorscheme 'catppuccin-mocha'
    end,
})

return plugs
