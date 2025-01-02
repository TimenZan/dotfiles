local plugs = {
    'tpope/vim-fugitive',
    'idanarye/vim-merginal',
    'tpope/vim-rhubarb',
    'shumphrey/fugitive-gitlab.vim',
    'junegunn/gv.vim',
    { 'lewis6991/gitsigns.nvim', opts = {}, },
    'rhysd/conflict-marker.vim',
    {
        'rhysd/git-messenger.vim',
        config = function ()
            -- let g:git_messenger_no_default_mappings=v:true
            vim.g.git_messenger_no_default_mappings = true
            vim.g.git_messenger_extra_blame_args = '-MCw'
            vim.g.git_messenger_floating_win_opts = { border = 'single' }
            -- nmap <leader>gm <Plug>(git-messenger)
            vim.keymap.set('n', '<leader>gm', '<Plug>(git-messenger)')
        end
    },
    {
        'rhysd/committia.vim',
        config = function ()
            vim.keymap.set({ 'n', 'i', 'v', 's' }, '<a-n>', '<Plug>(committia-scroll-diff-down-half)')
            vim.keymap.set({ 'n', 'i', 'v', 's' }, '<a-p>', '<Plug>(committia-scroll-diff-up-half)')
        end,
        lazy = false, -- Needs to be loaded before UI is drawn
    },
}

return require 'util'.all_verylazy(plugs)
