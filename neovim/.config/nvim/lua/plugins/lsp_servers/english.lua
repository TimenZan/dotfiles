-- Language servers for the English language

return {
    { ltex = require "tz.lsp.ltex" },
    { typos_lsp = {
        init_options = {
            config = "~/.local/share/nvim/typos.toml",
            diagnosticSeverity = "Warn",
        }
    }},
}
