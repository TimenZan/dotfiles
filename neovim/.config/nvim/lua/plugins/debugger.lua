local plugs = {}

-- table.insert(plugs, {
--     'rcarriga/nvim-dap-ui',
--     dependencies = {
--         'nvim-neotest/nvim-nio',
--     },
--     name = "dapui",
--     opts = {
--         icons = { expanded = "", collapsed = "" },
--         mappings = {
--             expand = { "<CR>", "<2-LeftMouse>" },
--             open = "o",
--             remove = "d",
--             edit = "e",
--             repl = "r",
--         },
--         layout = {
--             {
--                 elements = {
--                     -- Provide as ID strings or tables with "id" and "size" keys
--                     {
--                         id = "scopes",
--                         size = 0.25, -- Can be float or integer > 1
--                     },
--                     { id = "breakpoints", size = 0.25 },
--                     { id = "stacks",      size = 0.25 },
--                     { id = "watches",     size = 00.25 },
--                 },
--                 size = 40,
--                 position = "left", -- Can be "left", "right", "top", "bottom"
--             },
--             {
--                 elements = { "repl", "console" },
--                 size = 10,
--                 position = "bottom", -- Can be "left", "right", "top", "bottom"
--             },
--         },
--         floating = {
--             max_height = nil,  -- These can be integers or a float between 0 and 1.
--             max_width = nil,   -- Floats will be treated as percentage of your screen.
--             border = "single", -- Border style. Can be "single", "double" or "rounded"
--             mappings = {
--                 close = { "q", "<Esc>" },
--             },
--         },
--         windows = { indent = 1 },
--     },
--     -- event = 'VeryLazy',
--     lazy = true,
-- })

table.insert(plugs, {
    'mfussenegger/nvim-dap',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'theHamsta/nvim-dap-virtual-text',
        { 'rcarriga/nvim-dap-ui', name = 'dapui' },
        'nvim-telescope/telescope-dap.nvim',
        'LiadOz/nvim-dap-repl-highlights',
    },

    config = function ()
        local dap = require 'dap'
        local ui = require 'dapui'

        ui.setup {}
        require 'nvim-dap-virtual-text'.setup {}
        require 'nvim-dap-repl-highlights'.setup()
        -- vim.cmd 'TSInstall dap_repl'
        require 'nvim-treesitter.install'.ensure_installed 'dap_repl'

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
                program = function ()
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

        dap.adapters.haskell = {
            type = 'executable',
            command = 'haskell-debug-adapter',
            -- args = { '--hackage-version=0.0.33.0' },
        }
        dap.configurations.haskell = {
            {
                type = 'haskell',
                request = 'launch',
                name = 'Debug',
                workspace = '${workspaceFolder}',
                startup = "${file}",
                stopOnEntry = true,
                logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
                logLevel = 'WARNING',
                ghciEnv = vim.empty_dict(),
                ghciPrompt = "λ: ",
                -- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
                ghciInitialPrompt = "λ: ",
                ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
            },
        }

        dap.listeners.before.attach.dapui_config = ui.open
        dap.listeners.before.launch.dapui_config = ui.open
        dap.listeners.before.event_terminated.dapui_config = ui.close
        dap.listeners.before.event_exited.dapui_config = ui.close
    end,

    -- event = 'VeryLazy',

    -- cmd = {
    --     'DapContinue',
    --     'DapToggleBreakpoint',
    --     'DapTerminate',
    --     'DapStepOver',
    --     'DapToggleRepl',
    --     'DapStepOut',
    --     'DapShowLog',
    --     'DapLoadLaunchJSON',
    --     'DapEval',
    --     'DapStepInto',
    --     'DapNew',
    --     'DapSetLogLevel',
    --     'DapRestartFrame',
    -- },

    keys = {
        { '<leader>nc',  function () require 'dap'.continue() end },
        { '<leader>ns',  function () require 'dap'.step_over() end },
        { '<leader>ni',  function () require 'dap'.step_into() end },
        { '<leader>no',  function () require 'dap'.step_out() end },
        { '<leader>nb',  function () require 'dap'.toggle_breakpoint() end },
        { '<leader>nB',  function () require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
        { '<leader>nL',  function () require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end },
        { '<leader>nh',  function () require 'dap'.run_to_cursor() end },
        { '<leader>nr',  function () require 'dap'.run_last() end },
        { '<leader>n?',  function () require 'dapui'.eval(nil, { enter = true }) end },

        { '<leader>fnc', '<cmd>Telescope dap commands<cr>' },
        { '<leader>fns', '<cmd>Telescope dap configurations<cr>' },
        { '<leader>fnb', '<cmd>Telescope dap list_breakpoints<cr>' },
        { '<leader>fnv', '<cmd>Telescope dap variables<cr>' },
        { '<leader>fnf', '<cmd>Telescope dap frames<cr>' },
        -- nnoremap <silent> <leader>ndr <cmd>lua require'dap'.repl.open()<CR>
    },
})


table.insert(plugs, {
    "t-troebst/perfanno.nvim",
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    event = 'VeryLazy',
    -- TODO: lazy load plugin on commands and/or keybindings
    -- TODO: add keybindings or telescope/picker menu
    config = function ()
        require "perfanno".setup()
    end,
})

return plugs
