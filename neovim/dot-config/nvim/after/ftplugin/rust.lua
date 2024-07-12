-- Not needed, simply run `K` twice
-- vim.keymap.set('n', '<leader>fc', '<cmd>RustLsp hover actions<CR>')

vim.keymap.set('n', 'J', function () vim.cmd.RustLsp('joinLines') end)

-- vim.keymap.set('n', '<leader>a', function () vim.cmd.RustLsp('codeAction') end)
-- vim.g.rustaceanvim.tools.code_actions.ui_select_fallback = true

vim.keymap.set('n', '<leader>df', function () vim.cmd.RustLsp('renderDiagnostic') end)
