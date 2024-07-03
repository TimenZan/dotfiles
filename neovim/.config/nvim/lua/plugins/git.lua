local plugs = {
    'tpope/vim-fugitive',
    'idanarye/vim-merginal',
    'tpope/vim-rhubarb',
    'shumphrey/fugitive-gitlab.vim',
    'junegunn/gv.vim',
    { 'lewis6991/gitsigns.nvim', opts = {}, },
    'rhysd/conflict-marker.vim',
    -- {'rhysd/git-messenger.vim'
    --	let g:git_messenger_no_default_mappings=v:true
    --	nmap <leader>gm <Plug>(git-messenger)
    --	}
    {
        'rhysd/committia.vim',
        config = function()
            vim.keymap.set({ 'n', 'i', 'v', 's' }, '<a-n>', '<Plug>(committia-scroll-diff-down-half)')
            vim.keymap.set({ 'n', 'i', 'v', 's' }, '<a-p>', '<Plug>(committia-scroll-diff-up-half)')
        end
    },
}



return plugs
