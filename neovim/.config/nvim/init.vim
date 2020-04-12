"██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
"██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
"██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
"██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
"██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
" Housekeeping {{{
runtime! archlinux.vim

let mapleader =" "

set mouse=a
set encoding=utf-8

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" }}}

" Plugins {{{
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'roxma/nvim-yarp'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"	let g:coc_global_extensions = ['coc-snippets', 'coc-git', 'coc-vimtex', 'coc-java', 'coc-marketplace', 'coc-pairs']
Plug 'neovim/nvim-lsp'
	set omnifunc="v:lua.vim.lsp.omnifunc"
Plug 'Shougo/echodoc.vim'
	set shortmess+=c
	set noshowmode
	let g:echodoc_enable_at_startup=1
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
	let g:deoplete#enable_at_startup=1
Plug 'Shougo/deoplete-lsp'
Plug 'SirVer/ultisnips'
	" let g:UltisnipsExpandTrigger="<tab>"
	let g:UltisnipsJumpForwardTrigger="<c-b>"
	let g:UltisnipsJumpBackwardTrigger="<c-z>"
Plug 'vim-airline/vim-airline'
	let g:airline_powerline_fonts=1
	let g:airline#extensions#whitespace#mised_indent_algo=2
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
	let dart_format_on_save=1
Plug 'thosakwe/vim-flutter', { 'for': 'dart' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'config' }
Plug 'shirk/vim-gas'
Plug 'gillescastel/latex-snippets'
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
	let g:tex_conceal="abdgm"
Plug 'rust-lang/rust.vim'
Plug 'mrk21/yaml-vim'
	let g:rustfmt_autosave=1
Plug 'uiiaoo/java-syntax.vim'
Plug 'editorconfig/editorconfig-vim' " allows multiple style settings based on filetype
	let g:EditorConfig_exclude_patterns=['scp://.\*']
Plug 'sbdchd/neoformat' " TODO: setup for languages
Plug 'junegunn/vim-easy-align'
" Plug 'vim-syntastic/syntastic'
" "	let g:syntastic_java_checkers=['checkstyle']
" 	let g:syntastic_tex_checkers=['lacheck', 'text/language_check']
" 	let g:syntastic_aggregate_errors=1
" 	let g:syntastic_auto_loc_list=1
" 	let g:syntastic_check_on_open=1
" 	let g:syntastic_check_on_wq=0
" Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'
Plug 'mbbill/undotree'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " nice prose writing
Plug 'norcalli/nvim-colorizer.lua'
" Plug 'segeljakt/vim-isotope'
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'crusoexia/vim-monokai'
Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
Plug 'romainl/Apprentice'
Plug 'ananagame/vimsence', { 'on': [] } " Discord rich presence
Plug 'DougBeney/vim-reddit', { 'on': 'Reddit' }
Plug 'tweekmonster/startuptime.vim'
Plug '~/secrets/vim_credentials'
call plug#end()

colorscheme apprentice
augroup load_vimsence
	autocmd!
	autocmd CursorHold * call plug#load('vimsence')
	autocmd CursorHold * UpdatePresence
augroup END

" }}}

" Basics {{{
filetype plugin indent on
syntax on
set encoding=utf-8
set updatetime=100
set smartcase
set smartindent
set linebreak
set hidden
set scrolloff=5
set sidescrolloff=5
set complete=.,w,b,u,t,i,kspell
if (has("termguicolors"))
	set termguicolors
endif

set number relativenumber
" toggle absolute/relative number
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

let g:tex_flavor = "latex"


" let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
autocmd BufRead,BufNewFile markdown set textwidth=79

" }}}

" Bindings {{{

" <tab> triggers coc completion
" How it works: on <TAB> it checks if pum (Pop-Up Menu) is active, iff not it
" refreshes. then it checks if whitespace should be inserted, if it should:
" tab is inserted, if not, it fulfills the completion.
" I should try to get this to also complete a snippet if it is completelly
" typed, mayby, if the ergodox doesn't provide a better solution
"inoremap <silent><expr> <TAB>
"	\ pumvisible() ? "\<C-n>" :
"	\ <SID>check_back_space() ? "\<TAB>" :
"	\ coc#refresh()
"
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"imap <C-l> <Plug>(coc-snippets-expand)
"
"function! s:check_back_space() abort
"	let col = col('.') - 1
"	return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

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
require'nvim_lsp'.rls.setup{}
require'nvim_lsp'.vimls.setup({})
require'nvim_lsp'.yamlls.setup({})
require'nvim_lsp'.bashls.setup({})
require'nvim_lsp'.texlab.setup({})
EOF

" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0
