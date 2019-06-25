"██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
"██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
"██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
"██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
"██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

let mapleader =" "

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
" Languages
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'thosakwe/vim-flutter', { 'for': 'dart' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'config' }
Plug 'lervag/vimtex', { 'for': 'tex' } " adds tex functionality
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
Plug   'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
	set conceallevel=2
	let g:tex_conceal="abdgm"
Plug 'editorconfig/editorconfig-vim' " allows multiple style settings based on filetype
	let g:EditorConfig_exclude_patterns = ['scp://.\*']
" Snippets
"Plug 'valloric/youcompleteme' ", { 'do': './install.py --all'}
"	let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"	let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"	let g:SuperTabDefaultCompletionType = '<C-n>'
"Plug 'sirver/ultisnips' " snippets work fast
"	let g:UltiSnipsExpandTrigger = '<c-j>'
"	let g:UltiSnipsJumpForwardTrigger = '<c-j>'
"	let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
"	let g:UltiSnipsEditSplit="vertical"
"	let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
"	let g:UltiSnipsSnippetDirectories = ['UltiSnips']
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Utility
Plug 'mbbill/undotree'
Plug 'junegunn/goyo.vim' " nice prose writing
Plug 'RRethy/vim-hexokinase' " Adds colored boxes to hex codes
"	let g:Hexokinase_highlighters = ['sign_column']
Plug 'rhysd/git-messenger.vim' " Read the last Git commit message
Plug 'airblade/vim-gitgutter'
" Plug 'eslint/eslint' " javascript linter
" Plug 'segeljakt/vim-isotope'
" Colorschemes
Plug 'axvr/photon.vim' " adds multiple color schemes
Plug 'joshdick/onedark.vim'
" Plug 'anned20/vimsence' "Adds discord rich presence
Plug 'ananagame/vimsence' " Improved version
call plug#end()

" Some basics:
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	if (has("termguicolors"))
		set termguicolors
	endif
	try
		autocmd VimEnter * HexokinaseToggle
	catch
		try
			PlugInstall
		catch
			echo "Install vim-plug"
		endtry
	endtry

" toggle absolute/relative number
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" Interpret .md files, etc. as .markdown
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" .tex files automatically detected
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Readmes autowrap text:
	autocmd BufRead,BufNewFile *.md set tw=79

" Get line, word and character counts with F3:
	map <F3> :!wc %<CR>

" Spell-check set to F6:
	map <F6> :setlocal spell! spelllang=en_us<CR>

" Goyo plugin makes text more readable when writing prose:
	map <F10> :Goyo<CR>
	map <leader>f :Goyo \| set linebreak<CR>
	inoremap <F10> <esc>:Goyo<CR>a

" " Enable Goyo by default for mutt writting
" 	" Goyo's width will be the line limit in mutt.
" 	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
" 	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Automatically deletes all tralling whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

