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

        if vim.fn.executable('zathura') == 1 then
            vim.g.vimtex_view_method = 'zathura'
        elseif vim.fn.executable('skim') == 1 then
            vim.g.vimtex_view_method = 'skim'
        end

        -- the jobname is the root folder name (if found) + username + ISO date
        local rootname = ((string.match((vim.fs.root(0, { '.git', 'main.tex', 'latexmk_build', 'src', 'README.md' }) or ''), '/(%w+)$') or 'main') .. '_')
        local jobname = rootname .. (os.getenv('USER') or '') .. os.date('_%F')

        -- TODO: implement `-use-make?`
        vim.g.vimtex_compiler_latexmk = {
            out_dir = 'latexmk_build',
            aux_dir = 'latexmk_aux',
            options = {
                -- defaults
                '-verbose',
                '-file-line-error',
                '-synctex=1',
                '-interaction=nonstopmode',
                -- dox yourself in the filename
                '-jobname=' .. jobname,
            },
        }

        -- vim.g.vimtex_view_general_options = jobname .. '.pdf'
    end,
})

return plugs
