local plugs = {}

table.insert(plugs, {
    'petertriho/cmp-git',
    main = 'cmp_git',
    config = true,
})

table.insert(plugs, {
    'L3MON4D3/LuaSnip',
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    build = 'make install_jsregexp',
    config = function()
        local luasnip = require 'luasnip'
        local lstypes = require 'luasnip.util.types'
        luasnip.config.setup {
            ext_opts = {
                [lstypes.choiceNode] = {
                    active = {
                        virt_text = { { "●", "#fab387" }, },
                    },
                },
            },
        }
        require 'luasnip/loaders/from_vscode'.lazy_load()
        require 'luasnip.loaders.from_lua'.load({ paths = { "~/.config/nvim/snippets" } })
    end,
})

table.insert(plugs, {
    'hrsh7th/nvim-cmp',
    name = 'cmp',
    lazy = false,
    dependencies = {
        'JMarkin/cmp-diag-codes',
        'L3MON4D3/LuaSnip',
        'f3fora/cmp-spell',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-omni',
        'hrsh7th/cmp-path',
        'micangl/cmp-vimtex',
        'petertriho/cmp-git',
        'saadparwaiz1/cmp_luasnip',
        { 'windwp/nvim-autopairs', config = true, },
    },
    config = function()
        local cmp = require 'cmp'
        local comparators = require 'cmp.config.compare'
        local types = require 'cmp.types'
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        local luasnip = require 'luasnip'
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

        cmp.setup {
            preselect = types.cmp.PreselectMode.Item,
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            snippet = {
                expand = function(args)
                    require 'luasnip'.lsp_expand(args.body)
                end,
            },
            sorting = {
                priority_weight = 2,
                comparators = {
                    comparators.offset,
                    comparators.exact,
                    require 'clangd_extensions.cmp_scores',
                    comparators.score,
                    comparators.kind,
                    comparators.length,
                    comparators.order,
                    comparators.recently_used,
                    comparators.locality,
                    comparators.scopes,
                },
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
        }

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
    end,
})



return plugs
