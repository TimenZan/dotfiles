return {
    {
        clangd = {
            on_attach = function(client)
                require "clangd_extensions.inlay_hints".setup_autocmd()
                require "clangd_extensions.inlay_hints".set_inlay_hints()
            end
        }
    },
}
