local plugs = {}

table.insert(plugs, {
    'Vigemus/iron.nvim',
    disable = true,
    event = 'VeryLazy',
    config = function ()
        require 'iron.core'.setup {
            config = {
                scratch_repl = false,
                repl_definition = {
                    sh = {
                        command = { "fish" }
                    },
                    haskell = {
                        command = function (meta)
                            local file = vim.api.nvim_buf_get_name(meta.current_bufnr)
                            return require('haskell-tools').repl.mk_repl_cmd(file)
                        end
                    }
                },
                repl_open_cmd = require 'iron.view'.split.vertical.botright(80)
            },
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
            highlight = {
                italic = true
            },
            ignore_blank_lines = true,
        }

        -- iron also has a list of commands, see :h iron-commands for all available commands
        vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl<cr>')
        vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<cr>')
        vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>')
        vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>')
    end,
})

return plugs
