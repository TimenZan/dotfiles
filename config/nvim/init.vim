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
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'roxma/nvim-yarp'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"	let g:coc_global_extensions = ['coc-snippets', 'coc-git', 'coc-vimtex', 'coc-java', 'coc-marketplace', 'coc-pairs']
Plug 'neovim/nvim-lsp'
	set omnifunc="v:lua.vim.lsp.omnifunc"
Plug 'Shougo/echodoc.vim'
	set shortmess+=c
	set noshowmode
	let g:echodoc_enable_at_startup = 1
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
	let g:deoplete#enable_at_startup = 1
Plug 'Shougo/deoplete-lsp'
Plug 'vim-airline/vim-airline'
	let g:airline_powerline_fonts = 1
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'airblade/vim-gitgutter'
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'thosakwe/vim-flutter', { 'for': 'dart' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'config' }
Plug 'shirk/vim-gas'
Plug 'gillescastel/latex-snippets'
Plug 'donRaphaco/neotex', { 'for': 'tex' }
	let g:neotex_enabled=2
	let g:neotex_latexdiff=1
Plug 'lervag/vimtex', { 'for': 'tex' } " adds tex functionality
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
Plug 'KeitaNakamura/tex-conceal.vim', { 'for': 'tex' }
	set conceallevel=2
	let g:tex_conceal="abdgm"
Plug 'rust-lang/rust.vim'
	let g:rustfmt_autosave=1
Plug 'editorconfig/editorconfig-vim' " allows multiple style settings based on filetype
	let g:EditorConfig_exclude_patterns=['scp://.\*']
" Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'
Plug 'mbbill/undotree'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " nice prose writing
Plug 'norcalli/nvim-colorizer.lua'
" Plug 'segeljakt/vim-isotope'
Plug 'joshdick/onedark.vim'
Plug 'ananagame/vimsence' , { 'on': [] } " Discord rich presence
call plug#end()

colorscheme onedark
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

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Get line, word and character counts with F3:
	map <F3> :!wc %<CR>

" Spell-check set to F6:
	map <F6> :setlocal spell! spelllang=en_us<CR>

" Goyo plugin makes text more readable when writing prose:
	map <F10> :Goyo<CR>
	map <leader>f :Goyo \| set linebreak<CR>
	inoremap <F10> <esc>:Goyo<CR>a
" }}}

" {{{ Functions
" {{{ Pretty Indent Line
" set list lcs=tab:\▏\ 
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

lua require'colorizer'.setup()
lua << EOF
require'nvim_lsp'.rls.setup{}
require'nvim_lsp'.vimls.setup({})
EOF

" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0
