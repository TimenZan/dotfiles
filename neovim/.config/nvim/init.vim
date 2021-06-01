"██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
"██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
"██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
"██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
"██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
" Housekeeping {{{
runtime! archlinux.vim

let mapleader =' '

set mouse=a

" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
" libs {{{
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
" }}}
" lsp {{{
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
" Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-lua/completion-nvim'
	let g:completion_enable_snippet = 'UltiSnips'
	let g:completion_confirm_key = "\<C-y>"
	let g:completion_enable_auto_popup = 1
" Plug 'hrsh7th/nvim-compe'
" 	let g:compe = {}
" 	let g:compe.enabled = v:true
" 	let g:compe.autocomplete = v:true
" 	let g:compe.debug = v:false
" 	let g:compe.min_length = 1
" 	let g:compe.preselect = 'enable'
" 	let g:compe.throttle_time = 80
" 	let g:compe.source_timeout = 200
" 	let g:compe.incomplete_delay = 400
" 	let g:compe.max_abbr_width = 100
" 	let g:compe.max_kind_width = 100
" 	let g:compe.max_menu_width = 100
" 	let g:compe.documentation = v:true

" 	let g:compe.source = {}
" 	let g:compe.source.path = v:true
" 	let g:compe.source.buffer = v:true
" 	let g:compe.source.calc = v:true
" 	let g:compe.source.nvim_lsp = v:true
" 	let g:compe.source.nvim_lua = v:true
" 	let g:compe.source.ultisnips = v:true
" inoremap <silent><expr> <C-p>     compe#complete()
" inoremap <silent><expr> <C-y>     compe#confirm('<C-y>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" " inoremap <silent><expr> <C-n>     compe#scroll({ 'delta': +4 })
" " inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
Plug 'SirVer/ultisnips'
	" let g:UltisnipsExpandTrigger="<tab>"
	let g:UltisnipsJumpForwardTrigger='<c-b>'
	let g:UltisnipsJumpBackwardTrigger='<c-z>'
Plug 'prabirshrestha/asyncomplete-emoji.vim'
if hostname() ==# 'arch-desktop'
	Plug '~/development/plugins/snippets'
else
	Plug 'TimenZan/my-snippets'
endif
Plug 'dense-analysis/ale'
	let g:ale_linters = {'rust': ['rls', 'cargo', 'rustfmt']}
	let g:ale_linters.cpp = ['gcc']
	let g:ale_linters.haskell = ['stack-ghc-mod', 'hlint']
	let g:ale_echo_msg_error_str = 'E'
	let g:ale_echo_msg_warning_str = 'W'
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" }}}
" vcs {{{
" git
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'lambdalisue/gina.vim' " either remove or learn to use
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'
	let g:git_messenger_no_default_mappings=v:true
	nmap <leader>gm <Plug>(git-messenger)
Plug 'rhysd/committia.vim' " set up correctly
" }}}
" languages {{{
" rust
Plug 'rust-lang/rust.vim'
	let g:rustfmt_autosave=1
Plug 'simrat39/rust-tools.nvim'
" haskell
Plug 'alx741/vim-stylishask'
Plug 'neovimhaskell/haskell-vim'
	let g:haskell_enable_quantification = 1
	let g:haskell_enable_recursivedo = 1
	let g:haskell_enable_arrowsyntax = 1
	let g:haskell_enable_pattern_synonyms = 1
	let g:haskell_enable_typeroles = 1
	let g:haskell_enable_static_pointers = 1
	let g:haskell_backpack = 1
" java
Plug 'uiiaoo/java-syntax.vim'
" dart
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
	let dart_format_on_save=1
Plug 'thosakwe/vim-flutter', { 'for': 'dart' }
" (la)tex
Plug 'KeitaNakamura/tex-conceal.vim', { 'for': 'tex' }
	set conceallevel=2
	let g:tex_conceal='abdgm'
	let g:tex_conceal_frac=1
Plug 'lervag/vimtex', { 'for': 'tex' }
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_compiler_progname='nvr'
	let g:vimtex_quickfix_mode=1
" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
	let g:mkdp_auto_start = 1
" config files
Plug 'kovetskiy/sxhkd-vim'
Plug 'mrk21/yaml-vim'
" esoteric
Plug 'shirk/vim-gas'
Plug 'CaffeineViking/vim-glsl'
" }}}
" UI {{{
Plug 'liuchengxu/vista.vim'
Plug 'preservim/nerdTree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Shougo/echodoc.vim'
	let g:echodoc#enable_at_startup=1
	let g:echodoc#type = 'popup'
Plug 'vim-airline/vim-airline'
	let g:airline_powerline_fonts=1
	let g:airline#extensions#whitespace#mised_indent_algo=2
Plug 'norcalli/nvim-colorizer.lua'
Plug 'p00f/nvim-ts-rainbow'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'nvim-telescope/telescope.nvim'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
	let g:lens#width_resize_max = 100
	let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
" }}}
" quality of life tools {{{
Plug 'junegunn/vim-easy-align'
	nmap ga <Plug>(EasyAlign)
	xmap ga <Plug>(EasyAlign)
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " nice prose writing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
	map  gc <Plug>Commentary
	nmap gcc <Plug>CommentairyLine
Plug 'tpope/vim-eunuch'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-swap'
Plug 'RRethy/vim-illuminate'
Plug 'editorconfig/editorconfig-vim' " allows multiple style settings based on filetype
	let g:EditorConfig_exclude_patterns=['scp://.\*']
Plug 'wellle/targets.vim'
Plug 'wellle/context.vim'
Plug 'windwp/nvim-autopairs'
Plug 'preservim/nerdcommenter'
" }}}
" colorschemes {{{
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'crusoexia/vim-monokai'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'romainl/Apprentice', { 'branch': 'fancylines-and-neovim' }
" }}}
" misc {{{
Plug 'tweekmonster/startuptime.vim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" }}}
Plug '~/secrets/vim_credentials'
call plug#end()

colorscheme ayu

" Use completion-nvim in every buffer
augroup completionenable
	autocmd BufEnter * lua require'completion'.on_attach()
augroup END

" }}}

" Options {{{
filetype plugin indent on
syntax on
scriptencoding=utf-8
set updatetime=100
set undofile
set smartcase
set incsearch
set smartindent
set linebreak
set hidden
set scrolloff=5
set sidescrolloff=5
" set complete=.,w,b,u,t,i,kspell
set completeopt=menuone,noselect
set shortmess+=c
set noshowmode
set signcolumn=yes
if (has('termguicolors'))
	set termguicolors
endif

set number relativenumber
" toggle absolute/relative number
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 500 }

" trigger `autoread` when files changes on disk
" don't do this in vscode, as this breaks
if !exists('g:vscode')
	set autoread
	augroup filereload
		autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
		" notification after file change
		autocmd FileChangedShellPost *
					\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
	augroup END
endif

" augroup rusthints
" 	autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "NonText", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
" augroup END

" }}}

" Bindings {{{

" Make Y behave like other capitals
nnoremap Y y$
vnoremap @ :norm@

" :h vim.lsp.buf
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> g=    <cmd>lua vim.lsp.buf.formatting(nil)<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>


nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

imap <silent> <c-p> <Plug>(completion_trigger)

map <F3> g<c-g>
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F10> :Goyo<CR>
map <leader>f :Goyo \| set linebreak<CR>
inoremap <F10> <esc>:Goyo<CR>a

" Use esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>


" }}}

" {{{ Functions

lua require'colorizer'.setup()
lua << EOF
-- require'lspconfig'.rls.setup({})
require'lspconfig'.rust_analyzer.setup({})
require'lspconfig'.vimls.setup({})
require'lspconfig'.yamlls.setup({})
require'lspconfig'.bashls.setup({})
require'lspconfig'.texlab.setup({})
require'lspconfig'.clangd.setup({})

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
			other_hints_prefix = ">=>",
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
	server = {}, -- options for rust-analyzer
}
require'rust-tools'.setup(rust_opts)

require('nvim-autopairs').setup()
EOF

" treesitter setup
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	--ignore_install = { "javascript" }, -- List of parsers to ignore installing
	highlight = {
		enable = true,              -- false will disable the whole extension
		-- disable = { "c", "rust" },  -- list of language that will be disabled
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true
	},
	-- requires nvim-ts-rainbow plugin
	rainbow = {
		enable = true,
		extended_mode = true,
	},
}
EOF

" treesitter folding
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0
