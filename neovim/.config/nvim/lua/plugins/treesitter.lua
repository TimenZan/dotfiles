local plugs = {}

table.insert(plugs, {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ":TSUpdate",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            context_commentstring = { enable = true },
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
            sync_install = true,
            auto_install = true,
            ignore_install = {},
            highlight = {
                enable = true,
                disable = { "latex", "tex" },
                disable_ft = { "tex", "latex" },
                additional_vim_regex_highlighting = { "tex" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            indent = { enable = true },
        }
    end
})

table.insert(plugs, {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'VeryLazy',
    config = function()
        vim.cmd "hi TreesitterContextBottom gui=underline guisp=Grey"
        vim.cmd "hi TreesitterContextLineNumberBottom gui=underline guisp=Grey"
        vim.keymap.set('n', '[c', function()
            require 'treesitter-context'.go_to_context(vim.v.count1)
        end, { silent = true })
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
    depedencies = {
        { 'nvim-treesitter/nvim-treesitter'},
    },
    config = function()
        require 'nvim-treesitter.configs'.setup {
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    include_surrounding_whitespace = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },
                    goto_next = {
                        ["]d"] = "@conditional.outer",
                    },
                    goto_previous = {
                        ["[d"] = "@conditional.outer",
                    },
                },
            },
        }
        local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

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

return plugs
