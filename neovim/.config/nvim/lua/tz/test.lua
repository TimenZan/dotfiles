require("neotest").setup({
    adapters = {
        require("neotest-haskell")({
            dap = { justMyCode = false },
            build_tools = { 'stack', 'cabal' },
            frameworks = {
                {framework = 'tasty', modules = { "Test.Tasty", "from-upstream"}, },
            },
        }),
        require("neotest-rust")({}),
    },
    summary = {
        mappings = {
            output = "o",
            run = "r",
            jumpto = "<CR>",
        },
    },
})

local iron = require("iron.core")

iron.setup {
    config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
            sh = {
                -- Can be a table or a function that
                -- returns a table (see below)
                command = { "fish" }
            },
            haskell = {
                command = function(meta)
                    local file = vim.api.nvim_buf_get_name(meta.current_bufnr)
                    return require('haskell-tools').repl.mk_repl_cmd(file)
                end
            }
        },
        -- How the repl window will be displayed
        -- See below for more information
        -- repl_open_cmd = require('iron.view').split.vertical.topright(40),
        repl_open_cmd = "vertical botright 80 split"
    },
    -- Iron doesn't set keymaps by default anymore.
    -- You can set them here or manually add keymaps to the functions in iron.core
    keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = {
        italic = true
    },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')
