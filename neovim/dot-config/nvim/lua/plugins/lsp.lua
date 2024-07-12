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
    "neovim/nvim-lspconfig",
    config = function ()
        local capabilities = vim.tbl_deep_extend("force",
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )
        local util = require("util")
        local cur_dir = string.match(debug.getinfo(1, 'S').source, '^@(.*)/')
        local servers = util.iterate_dir('plugins.lsp_servers', cur_dir .. '/lsp_servers')
        for server, options in pairs(servers) do
            options.capabilities = capabilities
            require 'lspconfig'[server].setup { options }
        end
    end,
})

return plugs
