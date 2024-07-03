local plugs = {}

table.insert(plugs, {
    'rcarriga/nvim-dap-ui',
    name = "dapui",
    opts = {
        icons = { expanded = "", collapsed = "" },
        mappings = {
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
        },
        layout = {
            {
                elements = {
                    -- Provide as ID strings or tables with "id" and "size" keys
                    {
                        id = "scopes",
                        size = 0.25, -- Can be float or integer > 1
                    },
                    { id = "breakpoints", size = 0.25 },
                    { id = "stacks",      size = 0.25 },
                    { id = "watches",     size = 00.25 },
                },
                size = 40,
                position = "left", -- Can be "left", "right", "top", "bottom"
            },
            {
                elements = { "repl", "console" },
                size = 10,
                position = "bottom", -- Can be "left", "right", "top", "bottom"
            },
        },
        floating = {
            max_height = nil,  -- These can be integers or a float between 0 and 1.
            max_width = nil,   -- Floats will be treated as percentage of your screen.
            border = "single", -- Border style. Can be "single", "double" or "rounded"
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
    },
})

table.insert(plugs, {
    'mfussenegger/nvim-dap',
    dependencies = {
        { 'theHamsta/nvim-dap-virtual-text', config = true, lazy = false },
        'rcarriga/nvim-dap-ui',
        'nvim-telescope/telescope-dap.nvim',
    },

    config = function()
        local dap = require 'dap'

        dap.adapters.lldb = {
            type = 'executable',
            command = '/usr/bin/lldb-vscode',
            name = 'lldb',
        }

        dap.configurations.c = {
            {
                name = "Launch",
                type = "lldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
                --
                --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                --
                -- Otherwise you might get the following error:
                --
                --    Error on launch: Failed to attach to the target process
                --
                -- But you should be aware of the implications:
                -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
                runInTerminal = true,
            },
        }
    end,

    cmd = {
        'DapContinue',
        'DapToggleBreakpoint',
        'DapTerminate',
        'DapStepOver',
        'DapToggleRepl',
        'DapStepOut',
        'DapShowLog',
        'DapLoadLaunchJSON',
        'DapEval',
        'DapStepInto',
        'DapNew',
        'DapSetLogLevel',
        'DapRestartFrame',
    },

    keys = {
        { '<leader>nc',  function() require 'dap'.continue() end },
        { '<leader>ns',  function() require 'dap'.step_over() end },
        { '<leader>ni',  function() require 'dap'.step_into() end },
        { '<leader>no',  function() require 'dap'.step_out() end },
        { '<leader>nb',  function() require 'dap'.toggle_breakpoint() end },
        { '<leader>nB',  function() require 'dap'.set_breakpoint() end },
        { '<leader>nl',  function() require 'dap'.set_breakpoint() end },
        { '<leader>nr',  function() require 'dap'.run_last() end },
        { '<leader>fnc', '<cmd>Telescope dap commands<cr>' },
        { '<leader>fns', '<cmd>Telescope dap configurations<cr>' },
        { '<leader>fnb', '<cmd>Telescope dap list_breakpoints<cr>' },
        { '<leader>fnv', '<cmd>Telescope dap variables<cr>' },
        { '<leader>fnf', '<cmd>Telescope dap frames<cr>' },
        -- nnoremap <silent> <leader>ndr <cmd>lua require'dap'.repl.open()<CR>
    },
})


return plugs
