local diagnostics = {
    'diagnostics',
    -- table of diagnostic sources, available sources:
    -- nvim_lsp, coc, ale, vim_lsp
    sources = { 'nvim_diagnostic' },
    -- displays diagnostics from defined severity
    sections = { 'error', 'warn', 'info', 'hint' }
    -- all colors are in format #rrggbb
    -- color_error = nil, -- changes diagnostic's error foreground color
    -- color_warn = nil, -- changes diagnostic's warn foreground color
    -- color_info = nil, -- Changes diagnostic's info foreground color
    -- color_hint = nil, -- Changes diagnostic's hint foreground color
    -- symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        -- theme = 'material',
        theme = 'catppuccin',
        component_separators = { '', '' },
        section_separators = { '', '' },
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress', 'location' },
        lualine_z = { diagnostics }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = { diagnostics }
    },
    tabline = {},
    extensions = { 'quickfix' }
}
