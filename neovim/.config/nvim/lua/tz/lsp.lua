
require'lspconfig'.vimls.setup({})
require'lspconfig'.yamlls.setup({})
require'lspconfig'.bashls.setup({})
require'lspconfig'.texlab.setup({})
require'lspconfig'.clangd.setup({})

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

local rust_capabilities = vim.lsp.protocol.make_client_capabilities()
rust_capabilities.textDocument.completion.completionItem.snippetSupport = true
rust_capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}
-- require'lspconfig'.rust_analyzer.setup({
-- 	capabilities = rust_capabilities,
-- })

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
		capabilities = rust_capabilities,
	}, -- options for rust-analyzer
}
require'rust-tools'.setup(rust_opts)

require'nvim-autopairs'.setup()
require'lsp_signature'.on_attach()
require'lspkind'.init({
	-- enables text annotations
	--
	-- default: true
	with_text = true,

	-- default symbol map
	-- can be either 'default' or
	-- 'codicons' for codicon preset (requires vscode-codicons font installed)
	--
	-- default: 'default'
	preset = 'default',

	-- override preset symbols
	--
	-- default: {}
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
	},
})

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

