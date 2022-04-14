local compare = require('cmp.config.compare')
local types = require('cmp.types')
local cmp = require('cmp')

local WIDE_HEIGHT = 40
local luasnip = require 'luasnip'

-- require'lsp_signature'.setup()
local lspkind = require 'lspkind'
lspkind.init({
    -- enables text annotations
    mode = 'symbol_text',

    -- default symbol map
    -- can be either 'default' or
    -- 'codicons' for codicon preset (requires vscode-codicons font installed)
    preset = 'default',

    -- override preset symbols
    symbol_map = {
        Text = '',
        Method = 'ƒ',
        Function = '',
        Constructor = '',
        Variable = '',
        Class = '',
        Interface = 'ﰮ',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '了',
        Keyword = '',
        Snippet = '﬌',
        Color = '',
        File = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = ''
    }
})
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

    mapping = {
        ['<c-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
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
        end
    },

    formatting = {
        deprecated = true,
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " ..
                vim_item.kind
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
                path = "[Path]"
            })[entry.source.name]
            return vim_item
        end
    },

    experimental = { ghost_text = true },

    sources = {
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'calc' },
        { name = 'buffer' },
        { name = 'spell' },
    }
}
