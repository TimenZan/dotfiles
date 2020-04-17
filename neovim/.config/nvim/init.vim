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

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd once VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" }}}

" Plugins {{{
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'roxma/nvim-yarp'
" completion {{{
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"	let g:coc_global_extensions = ['coc-snippets', 'coc-git', 'coc-vimtex', 'coc-java', 'coc-marketplace', 'coc-pairs']
Plug 'neovim/nvim-lsp'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
" 	let g:deoplete#enable_at_startup=1
" Plug 'Shougo/deoplete-lsp'
Plug 'haorenW1025/completion-nvim'
	let g:completion_enable_snippet = 'UltiSnips'
	let g:completion_enable_auto_hover = 1
	let g:completion_confirm_key = "\<C-y>"
	let g:completion_trigger_character = ['.', '::']
" Plug 'ncm2/float-preview.nvim' " general purpose, not just for ncm2, not
" needed for completion-nvim
"	let g:float_preview#docked=0
" }}}
Plug 'SirVer/ultisnips'
	" let g:UltisnipsExpandTrigger="<tab>"
	let g:UltisnipsJumpForwardTrigger='<c-b>'
	let g:UltisnipsJumpBackwardTrigger='<c-z>'
Plug 'gillescastel/latex-snippets'
" vcs {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'lambdalisue/gina.vim'
Plug 'rbong/vim-flog'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/git-messenger.vim'
	let g:git_messenger_no_default_mappings=v:true
	nmap <leader>gm <Plug>(git-messenger)
Plug 'rhysd/committia.vim'
" }}}
" languages {{{
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
	let dart_format_on_save=1
Plug 'thosakwe/vim-flutter', { 'for': 'dart' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'config' }
Plug 'shirk/vim-gas'
Plug 'kovetskiy/sxhkd-vim'
Plug 'donRaphaco/neotex', { 'for': 'tex' } " autobuilds the tex pdfs
	let g:neotex_enabled=2
	let g:neotex_latexdiff=1
Plug 'lervag/vimtex', { 'for': 'tex' } " adds tex functionality
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_compiler_progname='nvr'
	let g:vimtex_quickfix_mode=1
Plug 'KeitaNakamura/tex-conceal.vim', { 'for': 'tex' }
	set conceallevel=2
	let g:tex_conceal='abdgm'
Plug 'rust-lang/rust.vim'
	let g:rustfmt_autosave=1
Plug 'mrk21/yaml-vim'
Plug 'uiiaoo/java-syntax.vim'
Plug 'mattn/emmet-vim'
" }}}
Plug 'sbdchd/neoformat' " TODO: setup for languages
Plug 'dense-analysis/ale'
	let g:ale_linters = {'rust': ['rls', 'cargo', 'rustfmt']}
" Plug 'vim-syntastic/syntastic'
" "	let g:syntastic_java_checkers=['checkstyle']
" 	let g:syntastic_tex_checkers=['lacheck', 'text/language_check']
" 	let g:syntastic_aggregate_errors=1
" 	let g:syntastic_auto_loc_list=1
" 	let g:syntastic_check_on_open=1
" 	let g:syntastic_check_on_wq=0
" Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'
Plug 'scrooloose/nerdTree'
Plug 'Shougo/echodoc.vim'
	set shortmess+=c
	set noshowmode
	let g:echodoc_enable_at_startup=1
" editing tools {{{
Plug 'mbbill/undotree'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " nice prose writing
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
	map  gc <Plug>Commentary
	nmap gcc <Plug>CommentairyLine
Plug 'norcalli/nvim-colorizer.lua'
Plug 'editorconfig/editorconfig-vim' " allows multiple style settings based on filetype
	let g:EditorConfig_exclude_patterns=['scp://.\*']
" }}}
Plug 'vim-airline/vim-airline'
	let g:airline_powerline_fonts=1
	let g:airline#extensions#whitespace#mised_indent_algo=2
" Plug 'segeljakt/vim-isotope'
" colorschemes {{{
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'crusoexia/vim-monokai'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'romainl/Apprentice', { 'branch': 'fancylines-and-neovim' }
" }}}
" fun {{{
" Plug 'ananagame/vimsence', { 'on': [] } " Discord rich presence
Plug 'DougBeney/vim-reddit', { 'on': 'Reddit' }
Plug 'tweekmonster/startuptime.vim'
" }}}
Plug '~/secrets/vim_credentials'
" Plug 'mcchrish/info-window.nvim'
" 	nnoremap <silent> <c-g> :InfoWindowToggle<cr>
call plug#end()

colorscheme apprentice
" augroup load_vimsence
" 	autocmd!
" 	autocmd CursorHold * call plug#load('vimsence')
" 	autocmd CursorHold * UpdatePresence
" augroup END

" }}}

" Options {{{
filetype plugin indent on
syntax on
set encoding=utf-8
scriptencoding=utf-8
set updatetime=100
set smartcase
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

augroup completer
	autocmd BufEnter * lua require'completion'.on_attach()
augroup END

" }}}

" Bindings {{{

" Make Y behave like other capitals
nnoremap Y y$

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
"set tagfunc=
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

map <F3> :!wc %<CR>
map <F6> :setlocal spell! spelllang=en_us<CR>
map <F10> :Goyo<CR>
map <leader>f :Goyo \| set linebreak<CR>
inoremap <F10> <esc>:Goyo<CR>a

" }}}

" {{{ Functions
" {{{ Pretty Indent Line
" set list lcs=tab:\▏<20>
" let g:pretty_indent_namespace = nvim_create_namespace('pretty_indent')
"
" function! PrettyIndent()
" 	let l:view=winsaveview()
" 	call cursor(1, 1)
" 	call nvim_buf_clear_namespace(0, g:pretty_indent_namespace, 1, -1)
" 	while 1
" 		let l:match = search('^$', 'W')
" 		if l:match ==# 0
" 			break
" 		endif
" 		let l:indent = cindent(l:match)
" 		if l:indent > 0
" 			call nvim_buf_set_virtual_text(
" 						\   0,
" 						\   g:pretty_indent_namespace,
" 						\   l:match - 1,
" 						\   [[repeat(repeat(' ', &shiftwidth - 1) . '▏', l:indent / &shiftwidth), 'IndentGuide']],
" 						\   {}
" 						\)
" 		endif
" 	endwhile
" 	call winrestview(l:view)
" endfunction
"
" augroup PrettyIndent
" 	autocmd!
" 	autocmd TextChanged * call PrettyIndent()
" 	autocmd BufEnter * call PrettyIndent()
" 	autocmd InsertLeave * call PrettyIndent()
" augroup END
" }}}
" {{{ Syntastic
function! FindConfig(prefix, what, where)
	let cfg = findfile(a:what, escape(a:where, ' ') . ';')
	return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction

" autocmd FileType java let b:syntastic_java_checkstyle_config_file=
"     \ get(g:, 'syntastic_java_checkstyle_args', '') .
"     \ FindConfig('-c', 'checkstyle.xml', expand('<afile>:p:h', 1))
" }}}

lua require'colorizer'.setup()
lua << EOF
-- require'nvim_lsp'.rls.setup({})
-- require'nvim_lsp'.rust_analyzer.setup({})
require'nvim_lsp'.vimls.setup({})
require'nvim_lsp'.yamlls.setup({})
require'nvim_lsp'.bashls.setup({})
require'nvim_lsp'.texlab.setup({})
EOF

" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0
