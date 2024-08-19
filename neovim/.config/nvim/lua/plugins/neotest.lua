local plugs = {}

table.insert(plugs, {
    'nvim-neotest/neotest',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'mrcjkb/neotest-haskell',
        'stevanmilic/neotest-scala',
        'mrcjkb/rustaceanvim',
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

    cmd = 'Neotest',

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
