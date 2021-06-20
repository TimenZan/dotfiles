
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
