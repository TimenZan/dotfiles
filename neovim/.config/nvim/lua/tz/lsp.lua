local servers = {
    'vimls', 'yamlls', 'jsonls', 'bashls', 'texlab', 'pyright', 'tsserver', 'eslint',
    'cssls', 'html'
}

local capabilities = vim.tbl_deep_extend("force",
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

local on_attach = function(client)
    require 'illuminate'.on_attach(client)
end

for _, server in pairs(servers) do
    require 'lspconfig'[server].setup {
        capabilities = capabilities,
        on_attach = on_attach
    }
end

require 'lspconfig'.pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pyslp = {
            plugins = {
                black = {
                    enabled = true,
                    cache_config = true,
                },
                pycodestyle = {
                    ignore = {},
                    maxLineLength = 100
                },
            },
        },
    },
})

require 'lspconfig'.clangd.setup({
    capabilities = capabilities,
    on_attach = function(client)
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
        on_attach(client)
    end,
})

require 'lspconfig'.ltex.setup(require 'tz.lsp.ltex')

local proselint = {
    lintCommand = 'proselint -',
    lintStdin = true,
    lintFormats = { '%f:%l:%c: %m' },
    lintSeverity = 3, --marks everything as Info severity, same as ltex
}
local efm_languages = {
    tex = {
        proselint,
    },
    gitcommit = {
        proselint,
    },
    markdown = {
        proselint,
    },
    plaintext = {
        proselint,
    },
    bib = {
        proselint,
    },
}
local efm_filetypes = {}
for key, _ in pairs(efm_languages) do table.insert(efm_filetypes, key) end

require 'lspconfig'.efm.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        documentFormatting = false,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true
    },
    settings = { rootMarkers = { '.git/' }, languages = efm_languages },
    filetypes = efm_filetypes
}

-- require 'lspconfig'.arduino_language_server.setup {
--     cmd = {
--         "arduino-language-server",
--         "-cli", "/bin/arduino-cli",
--         "-cli-config", "~/.arduino15/arduino-cli.yaml",
--         "-clangd", "/bin/clangd",
--         "-board-name", "Generic STM32F103C series",
--         "-fqbn", "stm32duino:STM32F1:genericSTM32F103C",
--         -- "-log",
--     },
-- }

require 'lspconfig'.lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
}

local rust_opts = {
    tools = {
        runnables = {
            use_telescope = true -- use telescope.nvim
        },
        inlay_hints = {
            parameter_hints_prefix = " « ",
            -- other_hints_prefix = " » ",
            other_hints_prefix = ">=> ",
            -- max_len_align_padding = false, -- don't align to longest line in file
            -- right_align = false            -- don't align to the extreme right
        },
        -- hover_actions = {
        --     -- see vim.api.nvim_open_win()
        --     border = {
        --         { "╭", "FloatBorder" }, { "─", "FloatBorder" },
        --         { "╮", "FloatBorder" }, { "│", "FloatBorder" },
        --         { "╯", "FloatBorder" }, { "─", "FloatBorder" },
        --         { "╰", "FloatBorder" }, { "│", "FloatBorder" }
        --     },
        --     auto_focus = true,
        -- },
    },
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } }
    },
}
require 'rust-tools'.setup(rust_opts)
