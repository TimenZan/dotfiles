local compare = require('cmp.config.compare')
local types = require('cmp.types')
local cmp = require('cmp')

require 'cmp_git'.setup()

local WIDE_HEIGHT = 40
local luasnip = require 'luasnip'
require 'luasnip/loaders/from_vscode'.lazy_load()
require 'luasnip.loaders.from_lua'.load({ paths = "~/.config/nvim/snippets" })

-- local lspkind = require 'lspkind'

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

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local mapping = {
    ['<c-space>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
    }),

    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),

    ["<A-n>"] = cmp.mapping.scroll_docs(-4),
    ["<A-p>"] = cmp.mapping.scroll_docs(4),

    ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- that way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif has_words_before() then
            cmp.complete()
        else
            fallback()
        end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),

    -- ["<C-x>"] = cmp.mapping.complete({ config = {} }),
}

cmp.setup({

    preselect = types.cmp.PreselectMode.Item,

    -- experimental = { ghost_text = true },

    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },


    sorting = {
        priority_weight = 2,
        comparators = {
            compare.offset, compare.exact,
            require('clangd_extensions.cmp_scores'),
            compare.score, compare.kind,
            compare.sort_text, compare.length, compare.order
        }
    },

    mapping = mapping,

    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        -- { name = 'vimtex' },
        { name = 'nvim_lua' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'nvim_lsp' },
    }, {
        { name = 'path' },
        { name = 'calc' },
    }, {
        { name = 'cmp_git' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'spell',  keyword_length = 3 },
    }),
})


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
