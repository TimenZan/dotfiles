local plugs = {}

table.insert(plugs, {
    "lervag/vimtex",
    lazy = false,
    ft = { 'tex', },
    init = function()
        vim.g.tex_flavor = 'lualatex'
        vim.g.vimtex_compiler_progname = 'nvr'
        vim.g.vimtex_quickfix_mode = 1
        vim.g.vimtex_view_method = 'zathura'
    end,
})

return plugs
