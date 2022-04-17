"██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
"██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
"██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
"██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
"██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

let mapleader = ' '
let g:python3_host_prog = '/usr/bin/python3'

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
" libs {{{
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'tpope/vim-repeat'
Plug 'winston0410/cmd-parser.nvim'
" }}}
" lsp {{{
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-calc'
Plug 'f3fora/cmp-spell'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'rafamadriz/friendly-snippets'
Plug 'weilbith/nvim-lsp-smag' " SMArt taGs
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
Plug 'rhysd/conflict-marker.vim'
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
	let g:dart_format_on_save = 1
	let g:dart_style_guide = 2
Plug 'Nash0x7E2/awesome-flutter-snippets'
Plug 'akinsho/flutter-tools.nvim'
" [la]tex
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
" arduino
Plug 'stevearc/vim-arduino'
	let g:arduino_dir = '/usr/share/arduino'
	let g:arduino_home_dir = $HOME . '.arduino15'
" config files
Plug 'mrk21/yaml-vim'
" esoteric
Plug 'shirk/vim-gas'
Plug 'CaffeineViking/vim-glsl'
" }}}
" UI {{{
Plug '~/development/vim-concealer'
Plug 'mfussenegger/nvim-dap'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'hoob3rt/lualine.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'p00f/nvim-ts-rainbow'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-bibtex.nvim' " TODO: set to use global `.bib`
Plug 'nvim-telescope/telescope-symbols.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'crispgm/telescope-heading.nvim'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
	let g:lens#width_resize_max = 100
	let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
Plug 'lukas-reineke/indent-blankline.nvim'
	let g:indentLine_char = '▏'
	let g:indent_blankline_use_treesitter = v:true
	let g:indentLine_fileTypeExclude = ['help']
	let g:indent_blankline_show_current_context = v:false
Plug 'winston0410/range-highlight.nvim'
Plug 'kassio/neoterm'
Plug 'romgrk/nvim-treesitter-context'
Plug 'haringsrob/nvim_context_vt'
Plug 'folke/trouble.nvim'
Plug 'tversteeg/registers.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'JASONews/glow-hover'
" }}}
" quality of life tools {{{
Plug 'junegunn/vim-easy-align'
	nmap <leader>ga <Plug>(EasyAlign)
	xmap <leader>ga <Plug>(EasyAlign)
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'tpope/vim-speeddating'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-eunuch'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-swap'
Plug 'RRethy/vim-illuminate'
Plug 'editorconfig/editorconfig-vim'
	let g:EditorConfig_exclude_patterns=['scp://.\*']
Plug 'wellle/targets.vim'
Plug 'windwp/nvim-autopairs'
Plug 'wsdjeg/vim-fetch'
Plug 'jessarcher/vim-heritage'
Plug 'andymass/vim-matchup'
	let g:matchup_matchparen_offscreen = {}
" }}}
" colorschemes {{{
Plug 'morhetz/gruvbox'
Plug 'ray-x/starry.nvim'
" }}}
" misc {{{
Plug 'tweekmonster/startuptime.vim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" }}}
Plug '~/development/nvim-fatal'
call plug#end()

colorscheme gruvbox

" }}}

" Options {{{
filetype plugin indent on
syntax on
scriptencoding=utf-8
set autowrite
set completeopt=menuone,noselect
set formatoptions=jcroqln1
set ignorecase | set smartcase
set inccommand=split
set incsearch
set lazyredraw
set linebreak
set mouse=a
set noshowmode
set nowrap
set scrolloff=5
set shiftround
set shortmess+=c
set sidescrolloff=5
set signcolumn=yes
set smartindent
set undofile
set updatetime=100
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
" if !exists('g:vscode')
if v:false
	set autoread
	augroup filereload
		autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
		" notification after file change
		autocmd FileChangedShellPost *
					\ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
	augroup END
endif

let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim', 'rust', 'javascript']

" }}}

" Bindings {{{

" Make `@` work on multiple lines
vnoremap @ :norm@

" center screen and unfold on search
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv

" :h vim.lsp.buf
nnoremap <silent> gd         <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD         <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> 1gD        <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K          <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-k>      <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr         <cmd>TroubleToggle lsp_references<CR>
nnoremap <silent> g0         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> g=         <cmd>lua vim.lsp.buf.formatting(nil)<CR>
nnoremap <silent> ga         <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> g[         <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g]         <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

" bindings for nvim-telescope start with <leader>f
nnoremap <leader>ff  <cmd>Telescope find_files<cr>
nnoremap <leader>fg  <cmd>Telescope live_grep<cr>
nnoremap <leader>fb  <cmd>Telescope buffers<cr>
nnoremap <leader>fh  <cmd>Telescope help_tags<cr>
nnoremap <leader>fr  <cmd>Telescope lsp_references<cr>
nnoremap <leader>fd  <cmd>Telescope lsp_workspace_diagnostics<cr>
nnoremap <leader>fa  <cmd>Telescope lsp_code_actions<cr>
nnoremap <leader>fsd <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>fsw <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <leader>fss <cmd>Telescope bibtex<cr>
nnoremap <leader>fse <cmd>lua require('telescope.builtin').symbols{sources = {'emoji', 'kaomoji'}}<cr>
nnoremap <leader>fsg <cmd>lua require('telescope.builtin').symbols{sources = {'gitmoji'}}<cr>
nnoremap <leader>fsm <cmd>lua require('telescope.builtin').symbols{sources = {'math'}}<cr>
nnoremap <leader>fsl <cmd>lua require('telescope.builtin').symbols{sources = {'latex'}}<cr>
" TODO: add searching through dictionary file

" bindings for nvim-dap
nnoremap <silent> <leader>nc <cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <leader>ns <cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <leader>ni <cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <leader>no <cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>nb <cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>nB <cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>nl <cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
"nnoremap <silent> <leader>ndr <cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>nr <cmd>lua require'dap'.run_last()<CR>
nnoremap <leader>fnc <cmd>Telescope dap commands<cr>
nnoremap <leader>fns <cmd>Telescope dap configurations<cr>
nnoremap <leader>fnb <cmd>Telescope dap list_breakpoints<cr>
nnoremap <leader>fnv <cmd>Telescope dap variables<cr>
nnoremap <leader>fnf <cmd>Telescope dap frames<cr>

" bindings for trouble.nvim
nnoremap <leader>dx <cmd>TroubleToggle<cr>
nnoremap <leader>dw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>dd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>dq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>dl <cmd>TroubleToggle loclist<cr>
nnoremap <leader>dr <cmd>TroubleToggle lsp_references<cr>

noremap <F3> g<c-g>
noremap <F6> :setlocal spell! spelllang=en_us<CR>
noremap <F10> :Goyo<CR>
" map <leader>f :Goyo \| set linebreak<CR>
inoremap <F10> <esc>:Goyo<CR>a

" Use esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

inoremap <silent><expr> <c-l> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-l>'
snoremap <silent> <c-l> <cmd>lua require('luasnip').jump(1)<CR>

" }}}

" {{{ Functions

lua require'tz.lsp'
lua require'tz.completion'
lua require'tz.line'
lua require'tz.dap'
lua require'tz.treesitter'
lua require'tz.ui'
lua require'Comment'.setup()

" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0
