require 'nvim-treesitter.configs'.setup {
    context_commentstring = {
        enable = true
    },
    ensure_installed = "all",
    sync_install = true,
    auto_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {"latex", "tex"},
        disable_ft = {"tex", "latex"},
        additional_vim_regex_highlighting = {"tex"},
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
    indent = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
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
        }
    }
}

require 'treesitter-context'.setup {}
vim.cmd("hi TreesitterContextBottom gui=underline guisp=Grey")
require 'nvim_context_vt'.setup {
    disable_ft = { 'markdown', 'dart' },
    prefix = ' ',
}
