
require'lspconfig'.vimls.setup({})
require'lspconfig'.yamlls.setup({})
require'lspconfig'.bashls.setup({})
require'lspconfig'.texlab.setup({})
require'lspconfig'.clangd.setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
-- table.insert(runtime_path, "lua/?/init.vim")
require'lspconfig'.sumneko_lua.setup({
	cmd = {'lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'};
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = runtime_path,
			},
			diagnostics = {
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

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
			--other_hints_prefix = " » ",
			other_hints_prefix = ">=> ",
			max_len_align_padding = false, -- don't align to longest line in file
			right_align = false, -- don't align to the extreme right
		},
		hover_actions = {
			-- see vim.api.nvim_open_win()
			border = {
				{"╭", "FloatBorder"},
				{"─", "FloatBorder"},
				{"╮", "FloatBorder"},
				{"│", "FloatBorder"},
				{"╯", "FloatBorder"},
				{"─", "FloatBorder"},
				{"╰", "FloatBorder"},
				{"│", "FloatBorder"},
			},
		},
	},
	server = {
		capabilities = capabilities,
	}, -- options for rust-analyzer
}
require'rust-tools'.setup(rust_opts)

require("flutter-tools").setup({
	widget_guides = {
		enabled = true,
	},
	closing_tags = {
		prefix = ">=> ",
	},
	dev_tools = {
		autostart = false,
		auto_open_browser = false,
	},
	lsp = {
		capabilities = capabilities,
	}, -- options for dartls
})

require'nvim-autopairs'.setup()
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

require'nvim-lightbulb'.update_lightbulb {
	sign = {
		enabled = true,
		-- Priority of the gutter sign
		priority = 10,
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
		win_opts = {},
	},
	virtual_text = {
		enabled = false,
		-- Text to show at virtual text
		text = "💡",
	},
	status_text = {
		enabled = false,
		-- Text to provide when code actions are available
		text = "💡",
		-- Text to provide when no actions are available
		text_unavailable = ""
	}
}

