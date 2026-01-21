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
        {
            'jmbuhr/telescope-zotero.nvim',
            dependencies = { { 'kkharji/sqlite.lua' }, },
            config = function ()
                require 'zotero'.setup {
                    ft = {
                        tex = {
                            insert_key_formatter = function (citekey)
                                return '\\autocite{' .. citekey .. '}'
                            end,
                            locate_bib = function ()
                                local rootfolder =
                                    vim.fs.root(0, { '.git', 'main.tex', 'latexmk_build', 'src', 'README.md' })
                                if not rootfolder then return nil end
                                local bibs = vim.fs.find({ 'references.bib', 'bibliography.bib', 'document.bib' },
                                    { type = "file", path = rootfolder })
                                return bibs[1]
                            end,
                        }
                    }
                }
            end,
        },
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
        telescope.load_extension 'zotero'
        telescope.load_extension 'dap'
    end,

    cmd = 'Telescope',

    keys = {
        { '<leader>ff',  '<cmd>Telescope find_files<cr>', },
        { '<leader>fg',  '<cmd>Telescope live_grep<cr>',                                                      mode = { 'n', 'v' } },
        { '<leader>fu',  '<cmd>Telescope grep_string<cr>',                                                    mode = { 'n', 'v' } },
        { '<leader>fb',  '<cmd>Telescope buffers<cr>', },
        { '<leader>fh',  '<cmd>Telescope help_tags<cr>', },
        { '<leader>fu',  '<cmd>Telescope lsp_references<cr>', },
        { '<leader>fr',  '<cmd>lua require("telescope.builtin").resume()<cr>', },
        { '<leader>fsd', '<cmd>Telescope lsp_document_symbols<cr>', },
        { '<leader>fsw', '<cmd>Telescope lsp_workspace_symbols<cr>', },
        { '<leader>fss', '<cmd>Telescope bibtex<cr>', },
        { '<a-f>z',      '<cmd>Telescope zotero<cr>',                                                         mode = 'i' },
        { '<leader>fse', "<cmd>lua require('telescope.builtin').symbols{sources = {'emoji', 'kaomoji'}}<cr>", },
        { '<leader>fsg', "<cmd>lua require('telescope.builtin').symbols{sources = {'gitmoji '}}<cr>", },
        { '<leader>fsm', "<cmd>lua require('telescope.builtin').symbols{sources = {'math '}}<cr>", },
        { '<leader>fsl', "<cmd>lua require('telescope.builtin').symbols{sources = {'latex '}}<cr>", },
    }
})


return plugs
