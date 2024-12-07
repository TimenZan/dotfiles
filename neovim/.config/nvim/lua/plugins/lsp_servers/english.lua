-- Language servers for the English language

return {
    { harper_ls = {} },
    { ltex = require "tz.lsp.ltex" },
    { typos_lsp = {
        init_options = {
            config = "~/.local/share/nvim/typos.toml",
            diagnosticSeverity = "Warn",
        }
    }},
}
