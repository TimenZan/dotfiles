"██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
"██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
"██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
"██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
"██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
" Housekeeping {{{
runtime! archlinux.vim
set shell=/bin/sh

let mapleader =' '

set mouse=a

" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
" lsp {{{
" Plug 'neovim/nvim-lsp'
" Plug 'haorenW1025/completion-nvim'
" 	let g:completion_enable_snippet = 'UltiSnips'
" 	let g:completion_enable_auto_hover = 1
" 	let g:completion_confirm_key = "\<C-y>"
" 	let g:completion_trigger_character = ['.', '::']
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
Plug 'prabirshrestha/vim-lsp'
	let g:lsp_diagnostic_enabled = 0
Plug 'mattn/vim-lsp-settings'
imap <c-space> <Plug>(asyncomplete_force_refresh)
Plug 'SirVer/ultisnips'
	" let g:UltisnipsExpandTrigger="<tab>"
	let g:UltisnipsJumpForwardTrigger='<c-b>'
	let g:UltisnipsJumpBackwardTrigger='<c-z>'
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
Plug 'sheerun/vim-polyglot'
" rust
Plug 'rust-lang/rust.vim'
	let g:rustfmt_autosave=1
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
" }}}
" UI {{{
Plug 'liuchengxu/vista.vim'
Plug 'scrooloose/nerdTree'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'Shougo/echodoc.vim'
	set shortmess+=c
	set noshowmode
	let g:echodoc#enable_at_startup=1
	let g:echodoc#type = 'popup'
Plug 'vim-airline/vim-airline'
	let g:airline_powerline_fonts=1
	let g:airline#extensions#whitespace#mised_indent_algo=2
Plug 'norcalli/nvim-colorizer.lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
" }}}
" quality of life tools {{{
Plug 'junegunn/vim-easy-align'
	nmap ga <Plug>(EasyAlign)
	xmap ga <Plug>(EasyAlign)
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " nice prose writing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
	map  gc <Plug>Commentary
	nmap gcc <Plug>CommentairyLine
Plug 'machakann/vim-swap'
Plug 'editorconfig/editorconfig-vim' " allows multiple style settings based on filetype
	let g:EditorConfig_exclude_patterns=['scp://.\*']
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
" }}}
Plug '~/secrets/vim_credentials'
call plug#end()

call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
	\ 'name': 'ultisnips',
	\ 'whitelist': ['*'],
	\ 'completor': function('asyncomplete#sources#ultisnips#completor'),
	\ }))

colorscheme apprentice

" }}}

" Options {{{
filetype plugin indent on
syntax on
set encoding=utf-8
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
set completeopt=menuone,noinsert,noselect
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

" augroup completer
" 	autocmd BufEnter * lua require'completion'.on_attach()
" augroup END

" }}}

" Bindings {{{

" Make Y behave like other capitals
nnoremap Y y$
vnoremap @ :norm@

" nmap <leader>rn rename
" nmap <silent> gd gotodefinition
" nmap <silent> gy coc-type-definition
" nmap <silent> gi coc-implementation
" nmap <silent> gr coc-reference
" nmap <silent> qf quickfix
"
" nmap <silent> <leader>a listdiagnostics
" nmap <silent> <leader>o coclist outline
" nmap <silent> <leader>j default action for next item
" nmap <silent> <leader>k default action for previous item
"
" nmap <silent> [g diagnosticsprev
" nmap <silent> ]g diagnosticsnext

" :h vim.lsp.buf
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

map <F3> :!wc %<CR>
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F10> :Goyo<CR>
map <leader>f :Goyo \| set linebreak<CR>
inoremap <F10> <esc>:Goyo<CR>a

" }}}

" {{{ Functions

lua require'colorizer'.setup()
lua << EOF
-- require'nvim_lsp'.rls.setup({})
-- require'nvim_lsp'.rust_analyzer.setup({})
-- require'nvim_lsp'.vimls.setup({})
-- require'nvim_lsp'.yamlls.setup({})
-- require'nvim_lsp'.bashls.setup({})
-- require'nvim_lsp'.texlab.setup({})
EOF

" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0
