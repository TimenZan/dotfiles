local plugs = {}

table.insert(plugs, { 'cuducos/yaml.nvim' })
table.insert(plugs, { 'HealsCodes/vim-gas' })
table.insert(plugs, { 'aklt/plantuml-syntax' })
table.insert(plugs, {
    'vim-scripts/lbnf.vim',
    config = function ()
        vim.cmd [[ au bufreadpre,bufnewfile *.cf set ft=lbnf ]]
    end
})

return plugs
