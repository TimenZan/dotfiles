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
    -- TODO: move back to original when my PR is merged
    { 'timenzan/targets.vim' },
    { 'wsdjeg/vim-fetch',        lazy = false, },
    { 'jessarcher/vim-heritage', },
    {
        'andymass/vim-matchup',
        lazy = false,
        init = function ()
            vim.g.matchup_matchparen_offscreen = {}
        end,
    },
}

return require 'util'.all_verylazy(plugs)
