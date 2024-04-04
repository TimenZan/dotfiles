vim.bo.expandtab = true
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2


local ht = require 'haskell-tools'
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr, }

vim.keymap.set('n', '<leader>hr', ht.repl.toggle, opts)
vim.keymap.set('n', '<leader>ha', ht.lsp.buf_eval_all, opts)
vim.keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
