local plugs = {}

table.insert(plugs, {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-bibtex.nvim',
        'nvim-telescope/telescope-symbols.nvim',
        'nvim-telescope/telescope-dap.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'crispgm/telescope-heading.nvim',
        'folke/trouble.nvim',
    },
    config = function ()
        local telescope = require 'telescope'
        local actions = require 'telescope.actions'
        local trouble_ts = require 'trouble.sources.telescope'

        telescope.setup { defaults = { mappings = {
            i = { ["<c-t>"] = trouble_ts.open },
            n = { ["<c-t>"] = trouble_ts.open },
        }, }, }

        telescope.load_extension 'fzf'
        telescope.load_extension 'heading'
        telescope.load_extension 'bibtex'
        telescope.load_extension 'dap'
    end,

    cmd = 'Telescope',

    keys = {
        { '<leader>ff',  '<cmd>Telescope find_files<cr>', },
        { '<leader>fg',  '<cmd>Telescope live_grep<cr>', },
        { '<leader>fb',  '<cmd>Telescope buffers<cr>', },
        { '<leader>fh',  '<cmd>Telescope help_tags<cr>', },
        { '<leader>fr',  '<cmd>Telescope lsp_references<cr>', },
        { '<leader>fsd', '<cmd>Telescope lsp_document_symbols<cr>', },
        { '<leader>fsw', '<cmd>Telescope lsp_workspace_symbols<cr>', },
        { '<leader>fss', '<cmd>Telescope bibtex<cr>', },
        { '<leader>fse', "<cmd>lua require('telescope.builtin').symbols{sources = {'emoji', 'kaomoji'}}<cr>", },
        { '<leader>fsg', "<cmd>lua require('telescope.builtin').symbols{sources = {'gitmoji '}}<cr>", },
        { '<leader>fsm', "<cmd>lua require('telescope.builtin').symbols{sources = {'math '}}<cr>", },
        { '<leader>fsl', "<cmd>lua require('telescope.builtin').symbols{sources = {'latex '}}<cr>", },
    }
})


return plugs
