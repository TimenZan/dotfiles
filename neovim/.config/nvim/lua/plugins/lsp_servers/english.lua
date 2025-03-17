-- Language servers for the English language

local nat_lsp = {
    typos_lsp = {
        init_options = {
            config = "~/.local/share/nvim/typos.toml",
            diagnosticSeverity = "Info",
        },
    },
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client == nil then
            return
        end
        if (nat_lsp[client.name]) then
            local ns = vim.lsp.diagnostic.get_namespace(client.id)
            vim.diagnostic.config({ virtual_text = true, virtual_lines = false, }, ns)
        end
    end
})

return { nat_lsp }
