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
            window = {
                winblend = 0,
            },
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
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        -- no desire for a dashboard
        dashboard = { enabled = false },
        -- handled by oil.nvim
        explorer = { enabled = false },
        -- git is handled elsewhere
        gh = { enabled = false },
        git = { enabled = false },
        gitbrowse = { enabled = false },
        -- I like images. TODO: add bindings and such
        image = { enabled = true },
        -- handled by indent-blankline
        indent = { enabled = false },
        -- good input
        input = {
            enabled = true,
            -- TODO: do we want completion?
            b = { completion = true },
        },
        -- I don't (currently) use lazygit
        lazygit = { enabled = false },
        -- handled by telescope, for now
        picker = { enabled = false },
        -- handled by fidget
        notifier = { enabled = false },
        -- Just get a faster init.lua
        quickfile = { enabled = false },
        -- library
        scope = { enabled = true },
        -- smoothscroll, TODO: do I like this?
        scroll = { enabled = false },
        -- handled by specific plugins
        -- TODO: replace them with this?
        statuscolumn = { enabled = false },
        -- handled by RRethy/vim-illuminate
        words = { enabled = false },
    },
})

table.insert(plugs, {
    'rachartier/tiny-inline-diagnostic.nvim',
    -- event = 'VeryLazy', -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    enabled = false,
    config = function ()
        vim.diagnostic.config {
            virtual_text = false,
            virtual_lines = { highlight_whole_line = false },
        }
        require('tiny-inline-diagnostic').setup {
            preset = 'simple',
            multiple_diag_under_cursor = true,
            options = {
                multilines = {
                    enabled = true,
                    always_show = true,
                },
            },
        }
    end
})

table.insert(plugs, { "tiagovla/scope.nvim", config = true })

table.insert(plugs, {
    'nvim-zh/colorful-winsep.nvim',
    event = { 'WinLeave' },
    opts = {
        smooth = false,
        only_line_seq = false,
    },
})

table.insert(plugs, {
    'stevearc/oil.nvim',
    lazy = false,
    config = function (opts)
        local snacks = require 'snacks'
        vim.api.nvim_create_autocmd("User", {
            pattern = "OilActionsPost",
            callback = function (event)
                if event.data.actions[1].type == "move" then
                    snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
                end
            end,
        })

        require 'oil'.setup(opts)
    end,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/snacks.nvim", }
})

table.insert(plugs, {
    'rachartier/tiny-code-action.nvim',
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
    },
    event = 'LspAttach',
    opts = {
        format_title = function (action, _)
            if action.kind then
                return string.format("%s (%s)", action.title, action.kind)
            end
            return action.title
        end,
    },
    keys = {
        { '<leader>a', function () require('tiny-code-action').code_action() end }
    }

})


return plugs
