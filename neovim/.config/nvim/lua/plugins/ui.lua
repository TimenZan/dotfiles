local plugs = {}

table.insert(plugs, {
    'winston0410/range-highlight.nvim',
    dependencies = {
        { 'winston0410/cmd-parser.nvim', lazy = false },
    },
    opts = {},
})

table.insert(plugs, {
    'j-hui/fidget.nvim',
    lazy = false,
    opts = {
        progress = {
            ignore_done_already = true,
            ignore = {
                'ltex',
            },
        },
        notification = {
            override_vim_notify = true,
            view = {
                group_separator = ''
            },
        },
    },
})

table.insert(plugs, {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'VeryLazy',
    config = function ()
        vim.g.indentLine_char = '▏'
        vim.g.indent_blankline_use_treesitter = true
        vim.g.indentLine_fileTypeExclude = { 'help' }
        vim.g.indent_blankline_show_current_context = false
        local hooks = require 'ibl.hooks'
        local highlight =
        { "RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan", }
        vim.g.rainbow_delimiters = { highlight = highlight }
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)

        require 'ibl'.setup { scope = { highlight = highlight } }
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
})

table.insert(plugs, {
    'tversteeg/registers.nvim',
    cmd = "Registers",
    opts = {
        symbols = {
            tab = "→",
            register_type_charwise = "⸱",
            register_type_linewise = "―",
            register_type_blockwise = "⸾", -- ⭿ ⋮
        },
    },
    keys = {
        { "\"",    mode = { "n", "v" } },
        { "<C-R>", mode = "i" }
    },
    name = "registers",
})

table.insert(plugs, {
    'camspiers/lens.vim',
    dependencies = {
        'camspiers/animate.vim',
    },
    enabled = false,
    init = function ()
        -- TODO: make dependent on filetype?
        -- vim.g.lens.width_resize_max = 100
        -- vim.g.lens.disabled_filetypes = { 'nerdtree', 'fzf' }
    end,
})

table.insert(plugs, {
    'stevearc/dressing.nvim',
    opts = {},
    lazy = false,
})

table.insert(plugs, {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function ()
        vim.diagnostic.config {
            virtual_text = false,
            virtual_lines = { highlight_whole_line = false },
        }
        require 'lsp_lines'.setup()
        -- Disable for pseudo-diagnostics created by `lazy.nvim`
        local lazy_namespace = vim.api.nvim_create_namespace('lazy')
        vim.diagnostic.config({ virtual_lines = false }, lazy_namespace)
    end,
    -- TODO: add keybinding to disable, maybe with some 'global' zen mode
    -- TODO: filter by language server?
})

return plugs
