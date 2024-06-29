local servers = {
    'vimls', 'yamlls', 'jsonls', 'bashls', 'texlab', 'pyright', 'tsserver', 'eslint',
    'cssls', 'html', 'taplo', 'jdtls', 'harper_ls'
}

local pragma_once = vim.api.nvim_create_augroup("MyLspConfig-7ce9faed-3f74-4011-b31e-38b0d0426781", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = pragma_once,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            if client.server_capabilities.inlayHintProvider then
                if vim.lsp.inlay_hint then
                    vim.lsp.inlay_hint.enable(true, nil)
                end
            end
        end
        -- whatever other lsp config you want
    end
})

local capabilities = vim.tbl_deep_extend("force",
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)

for _, server in pairs(servers) do
    require 'lspconfig'[server].setup {
        capabilities = capabilities,
    }
end

require 'lspconfig'.pylsp.setup({
    capabilities = capabilities,
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
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
}

vim.g.rustaceanvim = {
    server = {
        capabilities = capabilities,
    },
}
