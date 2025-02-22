-- Language servers for the English language

return {
    {
        typos_lsp = {
            init_options = {
                config = "~/.local/share/nvim/typos.toml",
                diagnosticSeverity = "Warn",
            },
        },
    },
}
