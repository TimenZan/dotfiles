local plugs = {}

local english = { "text", "tex", "gitcommit", "markdown", "plaintext", "bib", "rst", }

table.insert(plugs, {
    'mfussenegger/nvim-lint',
    lazy = false,
    config = function ()
        local lint = require 'lint'

        local langtool = lint.linters.languagetool
        -- vim.print(langtool.args)
        -- require 'fidget'.notify(vim.inspect(langtool.args), "info")
        -- langtool.args = {
        --     "--autodetect", "--json",
        --     "--config", "~/.config/LanguageTool/server.properties"
        -- }

        lint.linters_by_ft.fish = { 'fish' }
        lint.linters_by_ft.python = { 'ruff' }

        for ft, _ in pairs(lint.linters_by_ft) do
            vim.api.nvim_create_autocmd({ 'FileType', }, {
                callback = function ()
                    vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
                        callback = function ()
                            require 'lint'.try_lint()
                        end,
                    })
                end,
                pattern = ft,
            })
        end

        -- local nat_linters = { 'proselint', 'languagetool', }
        local nat_linters = { 'proselint', }

        -- For all "english" filetypes, register an autocmd to run proselint
        for _, ft in ipairs(english) do
            for _, linter in ipairs(nat_linters) do
                -- do not create virtual lines for spelling and grammar
                local ns = lint.get_namespace(linter)
                vim.diagnostic.config({ virtual_text = true, virtual_lines = false, }, ns)
                -- make all suggestions hints
                lint.linters[linter] =
                    require("lint.util").wrap(lint.linters[linter], function (diagnostic)
                        diagnostic.severity = vim.diagnostic.severity.HINT
                        if diagnostic.message == "Possible typo: you repeated a whitespace" then
                            return nil
                        end
                        return diagnostic
                    end)
            end
            lint.linters_by_ft[ft] = nat_linters


            vim.api.nvim_create_autocmd({ 'FileType', }, {
                callback = function ()
                    vim.api.nvim_create_autocmd({ 'FocusLost', }, {
                        -- vim.api.nvim_create_autocmd({ 'BufWritePost', }, {
                        callback = function ()
                            require 'lint'.try_lint()
                        end,
                    })
                end,
                pattern = ft,
            })
        end
    end,
})

return plugs
