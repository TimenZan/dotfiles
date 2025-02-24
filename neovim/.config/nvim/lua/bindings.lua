local set = vim.keymap.set

set('n', 'n', 'nzzzv', { silent = true, })
set('n', 'N', 'Nzzzv', { silent = true, })
set('v', '<', '<gv', { silent = true, })
set('v', '>', '>gv', { silent = true, })
set('n', 'x', '"_x', { silent = true, })
set('n', 'c', '"_c', { silent = true, })

set({ 'n', 'v', 'o' }, '<leader>y', '"+y')
set({ 'n', 'v', 'o' }, '<leader>Y', '"+y$')
set({ 'n', 'v', 'o' }, '<leader>p', '"+p')
set({ 'n', 'v', 'o' }, '<leader>P', '"+P')


-- Built in term bindings
set('n', '<leader>st', function ()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd('J')
    vim.api.nvim_win_set_height(0, 20)
end)
vim.cmd([[ tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi' ]])

-- LSP related bindings
set('n', '1gD', vim.lsp.buf.type_definition, { silent = true, })
set('n', '<c-k>', vim.lsp.buf.signature_help, { silent = true, })
set('n', '<leader>a', vim.lsp.buf.code_action, { silent = true, })
set('n', '<leader>l', vim.lsp.codelens.run, { silent = true, })
set('n', '<leader>rn', vim.lsp.buf.rename, { silent = true, })
set('n', 'g0', vim.lsp.buf.document_symbol, { silent = true, })
set('n', 'g=', function () vim.lsp.buf.format { async = true } end, { silent = true, })
set('n', 'gD', vim.lsp.buf.implementation, { silent = true, })
set('n', 'gW', vim.lsp.buf.workspace_symbol, { silent = true, })
set('n', 'gd', vim.lsp.buf.declaration, { silent = true, })

vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
vim.keymap.set("n", "J", function() return "mz" .. vim.v.count .. "J`z" end, {
    desc = "Join lines, keep cursor position",
    expr = true,
})

set('t', '<esc>', '<c-\\><c-n>')
