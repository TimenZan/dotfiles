local compare = require('cmp.config.compare')
local types = require('cmp.types')
local cmp = require('cmp')

require 'cmp_git'.setup()

local WIDE_HEIGHT = 40
local luasnip = require 'luasnip'
require 'luasnip/loaders/from_vscode'.lazy_load()
require 'luasnip.loaders.from_lua'.load({ paths = "~/.config/nvim/snippets" })

local lspkind = require 'lspkind'

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

-- lspkind.init({
--     -- enables text annotations
--     mode = 'symbol',
--     -- default symbol map
--     -- can be either 'default' or
--     -- 'codicons' for codicon preset (requires vscode-codicons font installed)
--     preset = 'default',
--     -- override preset symbols
--     symbol_map = {
--         Text = '',
--         Method = 'ƒ',
--         Function = '',
--         Constructor = '',
--         Variable = '',
--         Class = '',
--         Interface = 'ﰮ',
--         Module = '',
--         Property = '',
--         Unit = '',
--         Value = '',
--         Enum = '了',
--         Keyword = '',
--         Snippet = '﬌',
--         Color = '',
--         File = '',
--         Folder = '',
--         EnumMember = '',
--         Constant = '',
--         Struct = ''
--     }
-- })

local mapping = {
    ['<c-space>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
    }),
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true,
                true, true), 'n')
        elseif luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                '<Plug>luasnip-expand-or-jump', true, true,
                true), '')
        else
            fallback()
        end
    end,
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
}


cmp.setup {
    completion = {
        autocomplete = { types.cmp.TriggerEvent.TextChanged },
        completeopt = 'menu,menuone,noselect',
        keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
        keyword_length = 1,
        get_trigger_characters = function(trigger_characters)
            return trigger_characters
        end
    },

    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },

    preselect = types.cmp.PreselectMode.Item,

    window = {
        documentation = {
            border = { '', '', '', ' ', '', '', '', ' ' },
            winhighlight = 'NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder',
            maxwidth = math.floor((WIDE_HEIGHT * 2) *
                (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
            maxheight = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines))
        },
    },

    confirmation = {
        default_behavior = types.cmp.ConfirmBehavior.Insert,
        get_commit_characters = function(commit_characters)
            return commit_characters
        end
    },

    sorting = {
        priority_weight = 2,
        comparators = {
            compare.offset, compare.exact, compare.score, compare.kind,
            compare.sort_text, compare.length, compare.order
        }
    },

    event = {},

    mapping = mapping,

    formatting = {
        -- format = function(entry, vim_item)
        --     vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " ..
        --         vim_item.kind
        --     vim_item.menu = ({
        --         buffer = "[Buffer]",
        --         nvim_lsp = "[LSP]",
        --         luasnip = "[LuaSnip]",
        --         nvim_lua = "[Lua]",
        --         latex_symbols = "[Latex]",
        --         path = "[Path]"
        --     })[entry.source.name]
        --     return vim_item
        -- end
        format = lspkind.cmp_format({
            mode = 'symbol',       -- show only symbol annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                -- ...
                return vim_item
            end
        })
    },

    -- experimental = { ghost_text = true },

    sources = cmp.config.sources({
        { { name = 'nvim_lsp_signature_help' }, },
        {
            { name = 'vimtex' },
            { name = 'luasnip' },
            { name = 'nvim_lua' },
            { name = 'nvim_lsp' },
        },
        {
            { name = 'path' },
            { name = 'calc' },
        },
        {
            { name = 'cmp_git' },
            { name = 'buffer', keyword_length = 3 },
            { name = 'spell' , keyword_length = 3 },
        },
    })
}

-- -- Set configuration for specific filetype.
-- cmp.setup.filetype("gitcommit", {
--     sources = cmp.config.sources({
--         { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
--     }, {
--         { name = "buffer" },
--     }),
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    -- mapping = mapping,
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' },
            },
        },
    }, {
        { name = 'buffer' },
    }
    )
})
