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

        vim.keymap.set({ "i", "s" }, "<c-enter>", function ()
            if luasnip.choice_active() then
                luasnip.change_choice(1)
            end
        end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<c-s-enter>", function ()
            require 'luasnip.extras.select_choice' ()
        end, { silent = true })

        vim.keymap.set({ 'i', 's', 'n' }, "<C-l>", function ()
            -- if luasnip.expand_or_locally_jumpable() then
            --     luasnip.expand_or_jump()
            if luasnip.locally_jumpable() then
                luasnip.jump(1)
            else
                -- nop
            end
        end, { silent = true })
        vim.keymap.set({ 'i', 's', 'n' }, "<C-h>", function ()
            -- if luasnip.expand_or_locally_jumpable() then
            --     luasnip.expand_or_jump()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                -- nop
            end
        end, { silent = true })

        require 'luasnip/loaders/from_vscode'.lazy_load()
        require 'luasnip.loaders.from_lua'.load({ paths = { "~/.config/nvim/snippets" } })
    end,
})

table.insert(plugs, {
    'windwp/nvim-autopairs',
    config = function ()
        -- TODO: Add autopairs for generics <T>
        local ap = require 'nvim-autopairs'
        ap.setup {
            map_c_w = true,
            map_cr = true,
            disable_filetype = { "TelescopePrompt", "spectre_panel", },
            check_ts = true,
            ts_config = {},
            -- enables i_<A-e> to wrap an object in a pair
            fast_wrap = {},
        }
        ap.get_rules("'")[1].not_filetypes = { "tex" }
    end,

})

table.insert(plugs, {
    'hrsh7th/nvim-cmp',
    enabled = false,
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
        'windwp/nvim-autopairs',
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
    'saghen/blink.cmp',
    -- allows fetching of pre-built binaries
    version = '*',
    event = { 'InsertEnter', 'CmdlineEnter', },
    dependencies = {
        -- { 'L3MON4D3/LuaSnip',   version = '*' },
        { 'folke/lazydev.nvim', },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        -- TODO make similar to extant cmp.nvim, including default bindings
        keymap = {
            preset = 'none',
            ['<C-space>'] = { 'select_and_accept', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },

            ['<A-n>'] = { 'scroll_documentation_down', 'fallback' },
            ['<A-p>'] = { 'scroll_documentation_up', 'fallback' },

            ['<C-l>'] = { 'snippet_forward', 'fallback' },
            ['<C-h>'] = { 'snippet_backward', 'fallback' },

            -- ["<C-x>"] = {'hide', 'fallback'},
            -- ["<C-x>"] = {'cancel', 'fallback'},
            -- todo: keybind for enabling only specific providers

            cmdline = {
                ['<C-space>'] = { 'select_and_accept', 'fallback' },
                ['<tab>'] = { 'select_and_accept', 'fallback', },
                ['<S-tab>'] = { 'select_prev', 'fallback', },
                -- these two technically override builtin bindings, but the arrow version is strictly better as it takes
                -- into account the typed prefix.
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
            },
        },

        appearance = {
            nerd_font_variant = 'mono'
        },

        snippets = {
            expand = function (snippet) require('luasnip').lsp_expand(snippet) end,
            active = function (filter)
                if filter and filter.direction then
                    return require('luasnip').jumpable(filter.direction)
                end
                return require('luasnip').in_snippet()
            end,
            jump = function (direction) require('luasnip').jump(direction) end,
        },

        sources = {
            default = { 'lazydev', 'lsp', 'path', 'luasnip', 'buffer', },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
            -- TODO: use 'saghen/blink.compat' to include missing providers
            -- TODO: Spell complete only in comments (and maybe strings (and possibly variable names?))
            -- providers = function(ctx)
            --   local node = vim.treesitter.get_node()
            --   if vim.bo.filetype == 'lua' then
            --     return { 'lsp', 'path' }
            --   elseif node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
            --     return { 'buffer' }
            --   else
            --     return { 'lsp', 'path', 'snippets', 'buffer' }
            --   end
            -- end
        },

        signature = {
            enabled = true,
            window = {
                border = 'double',
            },
        },

        completion = {
            list = {
                selection = 'preselect',
            },
            accept = {
                create_undo_point = false,
                auto_brackets = {
                    enabled = true,
                },
            },
            menu = {
                border = 'single',
                draw = {
                    align_to= 'label',
                    treesitter = { 'lsp' },
                    columns = { { 'label', 'label_description', gap = 1 }, { 'source_name', }, { 'kind_icon', 'kind', gap = 1, }, },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 10,
                update_delay_ms = 10,
                window = {
                    border = 'single',
                },
            },
            ghost_text = {
                enabled = false,
            },
        },
    },
    opts_extend = { "sources.default" }
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
