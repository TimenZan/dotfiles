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

table.insert(plugs, {
    'b0o/incline.nvim',
    dependencies = {
        { 'lewis6991/gitsigns.nvim',    opts = {}, },
        { 'nvim-tree/nvim-web-devicons' },
    },
    config = function ()
        vim.o.laststatus = 3
        local devicons = require 'nvim-web-devicons'
        require('incline').setup {
            window = {
                padding = 0,
                -- placement = { horizontal = 'center', },
                margin = {
                    vertical = {
                        top = 0, bottom = 0,
                    },
                    horizontal = 0,
                },
            },
            hide = {
                cursorline = 'focused_win',
            },
            render = function (props)
                local colors = require 'catppuccin.palettes'.get_palette()
                local bgcol = props.focused and --[[isfocused]] colors.surface1 or colors.base
                local framecolor = props.focused and colors.red or colors.base
                local sepcolor = props.focused and colors.red or colors.crust

                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                if filename == '' then
                    filename = '[No Name]'
                end
                local ft_icon, ft_color = devicons.get_icon_color(filename)

                local function get_git_diff()
                    local icons = { removed = '-', changed = '~', added = '+' }
                    local signs = vim.b[props.buf].gitsigns_status_dict
                    local labels = {}
                    if signs == nil then
                        return labels
                    end
                    for name, icon in pairs(icons) do
                        if tonumber(signs[name]) and signs[name] > 0 then
                            table.insert(labels, { icon .. signs[name] .. '', group = 'Diff' .. name })
                        end
                    end
                    if #labels > 0 then
                        table.insert(labels, { '┃', guifg = sepcolor, })
                    end
                    return labels
                end

                local function get_diagnostic_label()
                    local icons = { error = '×', warn = '!', info = '?', hint = '' }
                    local label = {}

                    for severity, icon in pairs(icons) do
                        local n = #vim.diagnostic.get(props.buf,
                            { severity = vim.diagnostic.severity[string.upper(severity)] })
                        if n > 0 then
                            table.insert(label, { icon .. n .. '', group = 'DiagnosticSign' .. severity })
                        end
                    end
                    if #label > 0 then
                        table.insert(label, { '┃', guifg = sepcolor, })
                    end
                    return label
                end



                -- 
                -- 
                -- 
                -- 
                -- 
                -- 

                return {
                    { '', guifg = framecolor, guibg = colors.base },
                    { get_diagnostic_label() },
                    { get_git_diff() },
                    { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
                    { filename .. '', gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
                    { '', guifg = framecolor, guibg = colors.base },
                    -- { '┊  ' .. vim.api.nvim_win_get_number(props.win), group = 'DevIconWindows' }, -- bufnr
                    guibg = bgcol,
                }
            end,
        }
    end,
    event = 'VeryLazy',
})

return plugs
