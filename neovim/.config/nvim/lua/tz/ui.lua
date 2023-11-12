local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
    defaults = {
        mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
        },
    },
}

telescope.load_extension 'fzf'
telescope.load_extension 'heading'
telescope.load_extension 'bibtex'
telescope.load_extension 'dap'

-- require 'dressing'.setup {
--     input = {
--         insert_only = false,
--     },
--     select = {
--         backend = { 'telescope' }
--     },
-- }

-- require 'glow-hover'.setup {}

require 'nvim_context_vt'.setup {
    custom_text_handler = function(node)
        if vim.bo.filetype == 'dart' then
            return nil
        end
        return require 'nvim-treesitter.ts_utils'.get_node_text(node)[1]
    end
}

require 'colorizer'.setup()
require 'range-highlight'.setup {}
require 'gitsigns'.setup {}
require 'fidget'.setup {
    sources = {
        ltex = {
            ignore = true,
        },
    },
}
