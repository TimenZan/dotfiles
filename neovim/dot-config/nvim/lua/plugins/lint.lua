local plugs = {}

local english = { "text", "tex", "gitcommit", "markdown", "plaintext", "bib", }

table.insert(plugs, {
    'mfussenegger/nvim-lint',
    lazy = false,
    config = function ()
        -- For all "english" filetypes, register an autocmd to run proselint
        for _, ft in ipairs(english) do
            require 'lint'.linters_by_ft[ft] = { 'proselint', }
            vim.api.nvim_create_autocmd({ 'FileType', }, {
                callback = function ()
                    vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
                        callback = function () require 'lint'.try_lint() end,
                    })
                end,
                pattern = ft,
            })
        end
    end,
})

return plugs
