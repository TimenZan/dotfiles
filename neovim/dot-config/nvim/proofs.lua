local plugs = {}


table.insert(plugs, {
    'isovector/cornelis',
    dependencies = { 'neovimhaskell/nvim-hs.vim' },
    build = { 'stack build' },
    event = { 'BufEnter *.agda' },
})

table.insert(plugs, {
    'whonore/Coqtail',
})

table.insert(plugs, {
    'tomtomjhj/coq-lsp.nvim',
})

return plugs
