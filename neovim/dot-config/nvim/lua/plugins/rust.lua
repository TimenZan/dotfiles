local plugs = {}

table.insert(plugs, {
    'Saecki/crates.nvim',
    opts = {},
    event = { 'BufRead Cargo.toml', },
})

table.insert(plugs, {
    'mrcjkb/rustaceanvim',
    lazy = false,
})


return plugs
