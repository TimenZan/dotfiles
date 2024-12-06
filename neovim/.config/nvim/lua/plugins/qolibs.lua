local plugs = {
    { 'tpope/vim-repeat' },
    { 'tpope/vim-speeddating' },
    { 'tpope/vim-eunuch' },
    { 'tpope/vim-abolish' },
    { 'tpope/vim-characterize' },
    { 'tpope/vim-sleuth' },
    {
        'junegunn/vim-easy-align',
        keys = {
            { '<leader>ga', '<Plug>(EasyAlign)', mode = { 'n', 'v', 's' } },
        },
    },
    { 'machakann/vim-sandwich' },
    { 'machakann/vim-swap' },
    { 'RRethy/vim-illuminate' },
    { 'wellle/targets.vim' },
    { 'wsdjeg/vim-fetch',        lazy = false, },
    { 'jessarcher/vim-heritage', },
    {
        'andymass/vim-matchup',
        lazy = false,
        init = function ()
            vim.g.matchup_matchparen_offscreen = {}
        end,
    },
    { -- move out of encapsulating characters
        'abecodes/tabout.nvim',
        event = 'InsertCharPre',
        config = function ()
            require 'tabout'.setup {
                tabkey = '<c-l>',
                backwards_tabkey = '',
                act_as_tab = false,
                act_as_shift_tab = false,
                -- default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                -- default_shift_tab = '<C-d>', -- reverse shift default action,
                enable_backwards = true,
                completion = false,
                -- commented out since these are the default
                -- tabouts = {
                --     { open = "'", close = "'" },
                --     { open = '"', close = '"' },
                --     { open = '`', close = '`' },
                --     { open = '(', close = ')' },
                --     { open = '[', close = ']' },
                --     { open = '{', close = '}' }
                -- },
                ignore_beginning = false,
                exclude = {}
            }
        end,
        dependencies = { -- ensure tabout is loaded after these
            "nvim-treesitter/nvim-treesitter",
            "L3MON4D3/LuaSnip",
            "hrsh7th/nvim-cmp"
        },
    },
    {
        "pteroctopus/faster.nvim",
        opts = {
            -- threshold size, in MB
            filesize = 1,
        },
    },
}

return require 'util'.all_verylazy(plugs)
