local plugs = {}

table.insert(plugs, {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
        { "<leader>dw", '<cmd>Trouble diagnostics toggle<cr>', },
        { "<leader>dd", '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', },
        { "<leader>dq", '<cmd>Trouble qflist toggle<cr>', },
        { "<leader>dl", '<cmd>Trouble loclist toggle<cr>', },
        { "<leader>dr", '<cmd>Trouble symbols toggle<cr>', },
    },
})

return plugs
