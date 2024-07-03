local set = vim.keymap.set

set('n', 'n', 'nzzzv', { silent = true, })
set('n', 'N', 'Nzzzv', { silent = true, })
set('v', '<', '<gv', { silent = true, })
set('v', '>', '>gv', { silent = true, })

set('n', '1gD', vim.lsp.buf.type_definition, { silent = true, })
set('n', '<c-k>', vim.lsp.buf.signature_help, { silent = true, })
set('n', '<leader>a', vim.lsp.buf.code_action, { silent = true, })
set('n', '<leader>l', vim.lsp.codelens.run, { silent = true, })
set('n', '<leader>rn', vim.lsp.buf.rename, { silent = true, })
set('n', 'g0', vim.lsp.buf.document_symbol, { silent = true, })
set('n', 'g=', function() vim.lsp.buf.format { async = true } end, { silent = true, })
set('n', 'gD', vim.lsp.buf.implementation, { silent = true, })
set('n', 'gW', vim.lsp.buf.workspace_symbol, { silent = true, })
set('n', 'gd', vim.lsp.buf.declaration, { silent = true, })

set('t', '<esc>', '<c-\\><c-n>')
