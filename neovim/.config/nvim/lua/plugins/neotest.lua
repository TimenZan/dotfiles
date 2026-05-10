---@diagnostic disable: missing-fields
local plugs = {}

table.insert(plugs, {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'MisanthropicBit/neotest-busted',
        'mrcjkb/neotest-haskell',
        'mrcjkb/rustaceanvim',
        'stevanmilic/neotest-scala',
    },

    config = function ()
        require 'neotest'.setup {
            adapters = {
                require 'neotest-haskell' ({
                    dap = { justMyCode = false },
                    build_tools = { 'stack', 'cabal' },
                    frameworks = {
                        { framework = 'tasty', modules = { 'Test.Tasty', 'from-upstream' }, },
                    },
                }),
                require 'rustaceanvim.neotest',
                require 'neotest-scala' ({
                    args = { '--no-color' },
                    runner = 'sbt',
                    framework = 'utest',
                }),
                require("neotest-busted")({
                    --TODO: make pr to support versions of lua > 5.1
                    -- Leave as nil to let neotest-busted automatically find busted
                    -- busted_command = "<path to a busted executable>",
                    -- Do not use nvim to run busted, but run busted directly
                    no_nvim = false,
                    -- Extra arguments to busted
                    -- busted_args = { "--shuffle-files" },
                    -- List of paths to add to lua path lookups before running
                    -- busted, or a function returning a list of such paths
                    -- busted_paths = { "my/custom/path/?.lua" },
                    -- List of paths to add to lua cpath lookups before running
                    -- busted, or a function returning a list of such paths
                    -- busted_cpaths = { "my/custom/path/?.so" },
                    -- Custom config to load via -u to set up testing.
                    -- If nil, will look for a 'minimal_init.lua' file
                    -- minimal_init = "custom_init.lua",
                    -- Only use a luarocks installation in the project's directory. If
                    -- true, installations in $HOME and global installations will be
                    -- ignored. Useful for isolating the test environment
                    -- local_luarocks_only = true,
                    -- Find parametric tests
                    parametric_test_discovery = true,
                }),
            },
            summary = {
                mappings = {
                    output = 'o',
                    run = 'r',
                    jumpto = '<CR>',
                },
            },
        }
    end,

    keys = {
        { '<leader>ta', function () require 'neotest'.run.attach() end },
        { '<leader>td', function () require 'neotest'.run.run({ strategy = "dap" }) end },
        { '<leader>tf', function () require 'neotest'.run.run(vim.fn.expand("%")) end },
        { '<leader>tq', function () require 'neotest'.run.stop() end },
        { '<leader>tr', function () require 'neotest'.run.run() end },
        { '<leader>ts', function () require 'neotest'.summary.toggle() end },
        { '<leader>tt', function () require 'neotest'.run.run({ suite = true }) end },
    },
})

return plugs
