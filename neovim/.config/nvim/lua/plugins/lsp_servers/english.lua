-- Language servers for the English language

local nat_lsp = {
    typos_lsp = {
        init_options = {
            config = "~/.local/share/nvim/typos.toml",
            diagnosticSeverity = "Info",
        },
    },
}

local ltkey = vim.env.LANGUAGETOOL_API_KEY
local ltusr = vim.env.LANGUAGETOOL_API_USR
if ltkey and ltusr then
    nat_lsp.ltex_plus = {
        settings = {
            ltex = {
                checkFrequency = "save",
                language = "en-US",
                languageToolHttpServerUri = "https://api.languagetoolplus.com",
                additionalRules = {
                    motherTongue = "nl",
                    enablePickyRules = true,
                },
                disabledRules = {
                    ["en-US"] = { "QB_NEW_EN_OTHER_ERROR_IDS_5", "QB_NEW_EN_MERGED_MATCH" },
                },
                languageToolOrg = {
                    username = ltusr,
                    apiKey = ltkey,
                },
                latex = {
                    commands = {
                        -- Not how LTeX handles this now, TODO: open PR
                        ["\\textemdash"] = "—",
                    },
                },
            },
        },
    }
end

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
