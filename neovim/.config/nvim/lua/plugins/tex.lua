local plugs = {}

table.insert(plugs, {
    "lervag/vimtex",
    lazy = false,
    init = function ()
        vim.g.vimtex_quickfix_mode = 2
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_quickfix_ignore_filters = {
            'Underfull \\hbox',
            'Overfull \\hbox',
            'LaTeX Warning: .\\+ float specifier changed to',
        }
        -- vim.g.vimtex_imaps_enabled = 0
        vim.g.vimtex_delim_toggle_mod_list = {
            { '\\left', '\\right' },
            { '\\big',  '\\big' },
        }

        if vim.fn.executable('zathura') then
            vim.g.vimtex_view_method = 'zathura'
        elseif vim.fn.executable('skim') then
            vim.g.vimtex_view_method = 'skim'
        end

        vim.g.vimtex_compiler_latexmk = {
            out_dir = 'latexmk_build',
        }
    end,
})

return plugs
