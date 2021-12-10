local servers = {
    'vimls', 'yamlls', 'bashls', 'texlab', 'clangd', 'pyright',
    'jedi_language_server'
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
local on_attach = function(client)
    require'illuminate'.on_attach(client)
    require'lsp_signature'.on_attach()
end

for _, server in pairs(servers) do
    require'lspconfig'[server].setup {
        capabilities = capabilities,
        on_attach = on_attach
    }
end

local efm_languages = {
    lua = {{formatCommand = "lua-format -i", formatStdin = true}},
    vim = {
        {
            lintCommand = 'vint --enable-neovim --style-problems --no-color -',
            lintStdin = true,
            lintFormats = '%f:%l:%c: %m'
        }
    }
}
local efm_filetypes = {}
for key, _ in pairs(efm_languages) do table.insert(efm_filetypes, key) end

require'lspconfig'.efm.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        documentFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true
    },
    settings = {rootMarkers = {'.git/'}, languages = efm_languages},
    filetypes = efm_filetypes
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
require'lspconfig'.sumneko_lua.setup {
    capabilities = capabilities,
    cmd = {
        'lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'
    },
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = runtime_path},
            diagnostics = {globals = {'vim'}},
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    }
}

local rust_opts = {
    tools = {
        autoSetHints = true, -- automatically set inlay hints
        hover_with_actions = true, -- show hover actions in the hover window
        runnables = {
            use_telescope = true -- use telescope.nvim
        },
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = " « ",
            -- other_hints_prefix = " » ",
            other_hints_prefix = ">=> ",
            max_len_align_padding = false, -- don't align to longest line in file
            right_align = false -- don't align to the extreme right
        },
        hover_actions = {
            -- see vim.api.nvim_open_win()
            border = {
                {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                {"╰", "FloatBorder"}, {"│", "FloatBorder"}
            }
        }
    },
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {["rust-analyzer"] = {checkOnSave = {command = "clippy"}}}
    } -- options for rust-analyzer
}
require'rust-tools'.setup(rust_opts)

require("flutter-tools").setup({
    widget_guides = {enabled = true},
    closing_tags = {prefix = ">=> "},
    dev_tools = {autostart = false, auto_open_browser = false},
    lsp = {
        capabilities = capabilities,
        on_attach = function(client)
            require'illuminate'.on_attach(client)
        end
    } -- options for dartls
})

require'nvim-autopairs'.setup()
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

require'nvim-lightbulb'.update_lightbulb {
    sign = {
        enabled = true,
        -- Priority of the gutter sign
        priority = 10
    },
    float = {
        enabled = false,
        -- Text to show in the popup float
        text = "💡",
        -- Available keys for window options:
        -- - height     of floating window
        -- - width      of floating window
        -- - wrap_at    character to wrap at for computing height
        -- - max_width  maximal width of floating window
        -- - max_height maximal height of floating window
        -- - pad_left   number of columns to pad contents at left
        -- - pad_right  number of columns to pad contents at right
        -- - pad_top    number of lines to pad contents at top
        -- - pad_bottom number of lines to pad contents at bottom
        -- - offset_x   x-axis offset of the floating window
        -- - offset_y   y-axis offset of the floating window
        -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
        -- - winblend   transparency of the window (0-100)
        win_opts = {}
    },
    virtual_text = {enabled = false, text = "💡"},
    status_text = {enabled = false, text = "💡", text_unavailable = ""}
}

require'trouble'.setup {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = {"<c-x>"}, -- open buffer in new split
        open_vsplit = {"<c-v>"}, -- open buffer in new vsplit
        open_tab = {"<c-t>"}, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}
