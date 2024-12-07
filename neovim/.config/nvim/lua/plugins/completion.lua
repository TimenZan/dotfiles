local plugs = {}

table.insert(plugs, {
    'L3MON4D3/LuaSnip',
    dependencies = {
        'rafamadriz/friendly-snippets',
    },
    event = { 'InsertEnter', },
    build = 'make install_jsregexp',
    config = function ()
        local luasnip = require 'luasnip'
        local lstypes = require 'luasnip.util.types'
        luasnip.config.setup {
            ext_opts = {
                [lstypes.snippet] = {
                    active = { hl_group = "Underlined", },
                },
                [lstypes.choiceNode] = {
                    active = {
                        virt_text = { { "●", "#fab387" }, },
                    },
                },
                -- [lstypes.insertNode] = {
                --     active = {
                --         virt_text = { { "●", "Table" }, },
                --     },
                -- },
            },
            enable_autosnippets = true,
            cut_selection_keys = "<a-e>",
            update_events = 'TextChanged,TextChangedI,InsertLeave',
        }

        vim.keymap.set({ "i", "s" }, "<c-e>", function ()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<c-s-e>", function ()
            require 'luasnip.extras.select_choice' ()
        end, { silent = true })

        require 'luasnip/loaders/from_vscode'.lazy_load()
        require 'luasnip.loaders.from_lua'.load({ paths = { "~/.config/nvim/snippets" } })
    end,
})

table.insert(plugs, {
    'hrsh7th/nvim-cmp',
    name = 'cmp',
    event = { 'InsertEnter', 'CmdlineEnter', },
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
        { 'petertriho/cmp-git', config = true, main = 'cmp_git', },
        'saadparwaiz1/cmp_luasnip',
        {
            'windwp/nvim-autopairs',
            config = function ()
                local ap = require 'nvim-autopairs'
                ap.setup {
                    map_c_w = true,
                    disable_filetype = { "TelescopePrompt", "spectre_panel", "tex" },
                }
                ap.get_rules("'")[1].not_filetypes = { "tex" }
            end,
        },
    },
    config = function ()
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

            ["<C-l>"] = cmp.mapping(function (fallback)
                -- if luasnip.expand_or_locally_jumpable() then
                --     luasnip.expand_or_jump()
                if luasnip.locally_jumpable() then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { "i", "s", "n" }),

            ["<C-h>"] = cmp.mapping(function (fallback)
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
                expand = function (args)
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
                -- TODO only on "text like" files or in comments
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

table.insert(plugs, {
    'folke/lazydev.nvim',
    ft = 'lua',
    -- cmd = 'LazyDev',
    opts = {
        library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
            { path = 'LazyVim',            words = { 'LazyVim' } },
            { path = 'lazy.nvim',          words = { 'LazyVim' } },
        },
    },
})

table.insert(plugs, { "Bilal2453/luvit-meta", ft = 'lua', })


return plugs
