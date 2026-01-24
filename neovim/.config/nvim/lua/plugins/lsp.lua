local plugs = {}

local pragma_once = vim.api.nvim_create_augroup("MyLspConfig-7ce9faed-3f74-4011-b31e-38b0d0426781", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = pragma_once,
    callback = function (args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            if client.server_capabilities.inlayHintProvider then
                if vim.lsp.inlay_hint then
                    vim.lsp.inlay_hint.enable(true, nil)
                end
            end
        end
    end
})

table.insert(plugs, {
    'jmbuhr/otter.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {},
})


table.insert(plugs, {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            python = { "isort", "black" },
            bibtex = { "bibtex-tidy" },
            -- still experimental
            latex = { "llf" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = {
            lsp_format = "fallback",
            timeout_ms = 500,
        },
    },
})

table.insert(plugs, {
    "barreiroleo/ltex_extra.nvim",
    branch = "dev",
    ft = { "markdown", "tex", "text", "gitcommit" },
    opts = {
        ---@type string[]
        -- See https://valentjn.github.io/ltex/supported-languages.html#natural-languages
        load_langs = { "en-US", "nl-NL" },
        ---@type "none" | "fatal" | "error" | "warn" | "info" | "debug" | "trace"
        log_level = "info",
        ---@type string File's path to load.
        -- The setup will normalice it running vim.fs.normalize(path).
        -- e.g. subfolder in project root or cwd: ".ltex"
        -- e.g. cross project settings:  vim.fn.expand("~") .. "/.local/share/ltex"
        path = ".ltex",
    },
})

table.insert(plugs, {
    "neovim/nvim-lspconfig",
    dependencies = { 'b0o/schemastore.nvim' },
    config = function ()
        local util = require 'util'
        local cur_dir = string.match(debug.getinfo(1, 'S').source, '^@(.*)/')
        local servers = util.iterate_dir('plugins.lsp_servers', cur_dir .. '/lsp_servers')

        for server, options in pairs(servers) do
            vim.lsp.enable(server)
            -- Check if `options` is not empty
            if not (next(options) == nil) then
                vim.lsp.config(server, options)
            end
        end
    end,
})

return plugs
