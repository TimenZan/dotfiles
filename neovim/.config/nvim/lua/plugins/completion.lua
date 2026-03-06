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
    'saghen/blink.cmp',
    -- allows fetching of pre-built binaries
    version = '*',
    event = { 'InsertEnter', 'CmdlineEnter', },
    dependencies = {
        -- { 'L3MON4D3/LuaSnip',   version = '*' },
        { 'folke/lazydev.nvim', },
        {
            'AJamesyD/blink-cmp-rust.nvim',
            opts = {
                extra_common_traits = { 'Debug', 'Display', },
            },
        },
    },
    opts = function (_, opts)
        local rust_cmp = require 'blink-cmp-rust'
        local ret = vim.tbl_deep_extend('force', opts, {
            keymap = {
                preset = 'none',
                ['<C-space>'] = { 'select_and_accept', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-c>'] = { 'show', 'fallback' },

                ['<A-n>'] = { 'scroll_documentation_down', 'fallback' },
                ['<A-p>'] = { 'scroll_documentation_up', 'fallback' },

                ['<C-l>'] = { 'snippet_forward', 'fallback' },
                ['<C-h>'] = { 'snippet_backward', 'fallback' },

                -- ["<C-x>"] = {'hide', 'fallback'},
                -- ["<C-x>"] = {'cancel', 'fallback'},
                -- todo: keybind for enabling only specific providers

            },
            cmdline = {
                completion = { menu = { auto_show = true, }, },
                keymap = {
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

            -- snippets = {
            --     expand = function (snippet) require('luasnip').lsp_expand(snippet) end,
            --     active = function (filter)
            --         if filter and filter.direction then
            --             return require('luasnip').jumpable(filter.direction)
            --         end
            --         return require('luasnip').in_snippet()
            --     end,
            --     jump = function (direction) require('luasnip').jump(direction) end,
            -- },

            snippets = { preset = 'luasnip', },

            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    lsp = {
                        transform_items = function (ctx, items)
                            if opts.sources
                                and opts.sources.providers
                                and opts.sources.providers.lsp
                                and opts.sources.providers.lsp.transform_items
                            then
                                items = opts.sources.providers.lsp.transform_items(ctx, items)
                            end
                            return rust_cmp.transform_items(ctx, items)
                        end
                    }
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

            fuzzy = {
                sorts = function ()
                    local default_sorts = opts.fuzzy and opts.fuzzy.sorts
                    local base = type(default_sorts) == 'function' and default_sorts()
                        or default_sorts
                        or { 'score', 'sort_text' }
                    if vim.bo.filetype == 'rust' then
                        return vim.list_extend({ rust_cmp.compare }, base)
                    end
                    return base
                end,
            },

            signature = {
                enabled = true,
                window = {
                    border = 'double',
                },
            },

            completion = {
                list = {
                    selection = {
                        preselect = true,
                    },
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
                        align_to = 'label',
                        treesitter = { 'lsp' },
                        columns = { { 'label', 'label_description', gap = 1 }, { 'source_name', }, { 'kind_icon', 'kind', gap = 1, }, },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 10,
                    update_delay_ms = 50,
                    window = {
                        border = 'single',
                    },
                },
                ghost_text = {
                    enabled = false,
                },
            },
        })
        return ret
    end,
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
