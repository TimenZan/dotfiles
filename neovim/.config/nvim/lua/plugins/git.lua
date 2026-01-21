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
            local group = vim.api.nvim_create_augroup('committia-c318babd-6231-4e1f-b969-9c09f0c220d8', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = group,
                callback = function (ev)
                    if vim.bo[ev.buf].filetype == 'gitcommit' then
                        vim.keymap.set({ 'n', 'i', 'v', 's' }, '<a-n>', '<Plug>(committia-scroll-diff-down-half)',
                            { buffer = true })
                        vim.keymap.set({ 'n', 'i', 'v', 's' }, '<a-p>', '<Plug>(committia-scroll-diff-up-half)',
                            { buffer = true })
                    end
                end
            })
        end,
        lazy = false, -- Needs to be loaded before UI is drawn
    },
    {
        'ruifm/gitlinker.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = true,
    },
}

return require 'util'.all_verylazy(plugs)
