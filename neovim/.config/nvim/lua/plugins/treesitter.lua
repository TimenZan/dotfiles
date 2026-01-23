---@diagnostic disable: missing-fields
local plugs = {}

table.insert(plugs, {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ":TSUpdate",
    config = function ()
        local ts = require 'nvim-treesitter'
        ts.setup { install_dir = vim.fn.stdpath('data') .. '/site' }
        ts.install { "c", "comment", "lua", "vim", "vimdoc", "query", "haskell", "markdown", "markdown_inline" }

        -- require 'nvim-treesitter.configs'.setup {
        --     context_commentstring = { enable = true },
        --     sync_install = true,
        --     auto_install = true,
        --     ignore_install = {},
        --     incremental_selection = {
        --         enable = true,
        --         keymaps = {
        --             init_selection = "gnn",
        --             node_incremental = "grn",
        --             scope_incremental = "grc",
        --             node_decremental = "grm",
        --         },
        --     },
        -- }


        local disable_ft = { 'latex', 'tex', }

        local start = function ()
            vim.treesitter.start()
            -- TODO: treesitter indent is experimental
            -- TODO: only enable if parser supports it?
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
        vim.api.nvim_create_autocmd('FileType', {
            callback = function (ev)
                local ft = vim.bo[ev.buf].filetype
                local lang = vim.treesitter.language.get_lang(ft) or ft
                if vim.list_contains(disable_ft, lang) then
                    return
                end
                local installed = ts.get_installed()
                if vim.list_contains(installed, lang) then
                    start()
                    return
                end
                -- TODO: only get parsers of good maintenance status
                local avail = ts.get_available()
                if vim.list_contains(avail, lang) then
                    vim.notify('installing parser for ' .. lang, vim.log.levels.INFO)
                    ts.install(lang):wait(60000)
                    start()
                    return
                end
            end,
        })
    end
})

table.insert(plugs, {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function ()
        vim.cmd "hi TreesitterContextBottom gui=underline guisp=Grey"
        vim.cmd "hi TreesitterContextLineNumberBottom gui=underline guisp=Grey"
        vim.keymap.set('n', '[c', function ()
            require 'treesitter-context'.go_to_context(vim.v.count1)
        end, { silent = true, desc = 'Jump up to context' })
        require 'treesitter-context'.setup { multiwindow = true }
    end
})

table.insert(plugs, {
    'haringsrob/nvim_context_vt',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
        disable_ft = { 'markdown', 'dart' },
        prefix = ' ',
    },
})

table.insert(plugs, {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = 'VeryLazy',
    branch = 'main',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function ()
        require 'nvim-treesitter-textobjects'.setup {
            select = {
                lookahead = true,
                include_surrounding_whitespace = true,
            },
            move = { set_jumps = true, },
        }

        local select = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@comment.outer',
            ['ic'] = '@comment.inner',
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        }
        local swap_next = {
            ["<leader>s,"] = "@parameter.inner",
            ["<leader>ss"] = "@statement.outer",
        }
        local swap_previous = {
            ["<leader>S,"] = "@parameter.inner",
            ["<leader>SS"] = "@statement.outer",
            ["<leader>Ss"] = "@statement.outer",
        }
        local move = {
            goto_next_start = {
                [']f'] = '@function.outer',
                -- [']]'] = '@class.outer',
                ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
                [']F'] = '@function.outer',
                -- [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                -- ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[F'] = '@function.outer',
                -- ['[]'] = '@class.outer',
            },
            goto_next = {
                ["]d"] = "@conditional.outer",
            },
            goto_previous = {
                ["[d"] = "@conditional.outer",
            },
        }


        local bind = function (kvs, func, modes, description)
            for k, v in pairs(kvs) do
                local query_string = type(v) == 'string' and v or v.query
                local query_group = v.query_group or 'textobjects'

                local desc = (description or "") .. " " .. query_string

                vim.keymap.set(modes, k, function () func(query_string, query_group) end, { desc = desc })
            end
        end
        local tsselect = require 'nvim-treesitter-textobjects.select'.select_textobject

        bind(select, tsselect, { 'x', 'o' }, 'select')

        local tsswap = require 'nvim-treesitter-textobjects.swap'
        local tsswapnext = tsswap.swap_next
        bind(swap_next, tsswapnext, { 'n', 'x', 'o' }, 'swap next')
        local tsswapprevious = tsswap.swap_previous
        bind(swap_previous, tsswapprevious, { 'n', 'x', 'o' }, 'swap previous')

        local tsmove = require 'nvim-treesitter-textobjects.move'
        for k, v in pairs(move) do
            local func = tsmove[k]
            bind(v, func, { 'n', 'x', 'o' }, k)
        end

        local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
        -- Repeat movement with ; and ,
        -- ensure ; goes forward and , goes backward regardless of the last direction
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

        -- vim way: ; goes to the direction you were moving.
        -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
})

table.insert(plugs, {
    'https://github.com/Wansmer/sibling-swap.nvim',
    opts = {
        -- TODO: make filetype specific?
        -- TODO: add way of swapping chained streams (self.map(func).filter(func).iter())
        allowed_separators = {
            '%',
            '*',
            '**',
            '++',
            '..',
            '...',
            '..=',
            '/',
            '<$>',
            '<*>',
            '<<',
            '<>',
            '><',
            '>>',
            '^',
            '^^',
            ['*>'] = '<*',
            ['<*'] = '*>',
            ['>>='] = '=<<',
        }
    }
})

table.insert(plugs, {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter', },
    opts = { use_default_keymaps = false, },
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin', },
    keys = {
        { '<c-j>',     function () require 'treesj'.toggle { split = { recursive = false } } end },
        { '<cs-j>',    function () require 'treesj'.toggle { split = { recursive = true } } end },
        { '<leader>j', function () require 'treesj'.join { join = { recursive = false } } end },
        { '<leader>J', function () require 'treesj'.join { join = { recursive = true } } end },
    },
})


return plugs
