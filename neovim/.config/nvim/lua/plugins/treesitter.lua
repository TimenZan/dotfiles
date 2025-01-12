---@diagnostic disable: missing-fields
local plugs = {}

table.insert(plugs, {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    config = function ()
        require 'nvim-treesitter.configs'.setup {
            context_commentstring = { enable = true },
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "haskell" },
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
    config = function ()
        vim.cmd "hi TreesitterContextBottom gui=underline guisp=Grey"
        vim.cmd "hi TreesitterContextLineNumberBottom gui=underline guisp=Grey"
        vim.keymap.set('n', '[c', function ()
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
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function ()
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
                        ['ac'] = '@comment.outer',
                        ['ic'] = '@comment.inner',
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>s,"] = "@parameter.inner",
                        ["<leader>ss"] = "@statement.outer",
                    },
                    swap_previous = {
                        ["<leader>S,"] = "@parameter.inner",
                        ["<leader>SS"] = "@statement.outer",
                        ["<leader>Ss"] = "@statement.outer",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
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
                    -- goto_next = {
                    --     ["]d"] = "@conditional.outer",
                    -- },
                    -- goto_previous = {
                    --     ["[d"] = "@conditional.outer",
                    -- },
                },
                lsp_interop = {
                    enable = true,
                    border = 'none',
                    floating_preview_opts = {},
                    peek_definition_code = {
                        ["<leader>pf"] = "@function.outer",
                        ["<leader>pc"] = "@class.outer",
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
