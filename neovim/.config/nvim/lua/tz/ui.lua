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
    progress = {
        ignore_done_already = true,
        ignore = {
            "ltex",
        },
    },
    notification = {
        override_vim_notify = true,
        view = {
            group_separator = ""
        }
    },
}

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require 'ibl.hooks'
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require 'ibl'.setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
