local compare = require('cmp.config.compare')
local types = require('cmp.types')
local cmp = require('cmp')

require 'cmp_git'.setup()

local luasnip = require 'luasnip'
local lstypes = require 'luasnip.util.types'
luasnip.config.setup {
    ext_opts = {
        [lstypes.choiceNode] = {
            active = {
                virt_text = { { "●", "#fab387" } }
            },
        },
    },
}
require 'luasnip/loaders/from_vscode'.lazy_load()
require 'luasnip.loaders.from_lua'.load({ paths = "~/.config/nvim/snippets" })

-- local lspkind = require 'lspkind'

require 'nvim-autopairs'.setup()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

local mapping = {
    ['<c-space>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
    }),

    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Select }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Select }),

    ["<A-n>"] = cmp.mapping.scroll_docs(-4),
    ["<A-p>"] = cmp.mapping.scroll_docs(4),

    ["<C-l>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s", "n" }),

    ["<C-h>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s", "n" }),

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
            require('luasnip').lsp_expand(args.body)
        end,
    },

    sorting = {
        priority_weight = 2,
        comparators = {
            compare.offset,
            compare.exact,
            require('clangd_extensions.cmp_scores'),
            compare.score,
            compare.kind,
            compare.length,
            compare.order,
            compare.recently_used,
            compare.locality,
            compare.scopes,
        }
    },

    mapping = mapping,

    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'vimtex' },
        { name = 'nvim_lua' },
        { name = 'omni',                   option = { disable_omnifunc = {} } },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'crates' },
        { name = 'diag-codes' },
    }, {
        { name = 'path' },
        { name = 'calc' },
    }, {
        { name = 'git' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'spell',  keyword_length = 5 },
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
