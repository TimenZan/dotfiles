local plugs = {}

local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    sections = { 'error', 'warn', 'info', 'hint' }
}

table.insert(plugs, {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
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
        extensions = { 'quickfix', 'fugitive', 'lazy', 'fzf', 'trouble' },
    },
})

return plugs
