"██╗███╗   ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
"██║████╗  ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
"██║██╔██╗ ██║██║   ██║   ██║   ██║██║██╔████╔██║
"██║██║╚██╗██║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
"██║██║ ╚████║██║   ██║██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
runtime! archlinux.vim

let mapleader =" "

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
	let g:airline_powerline_fonts = 1
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim' " Read the last Git commit message
Plug 'airblade/vim-gitgutter'
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
Plug 'thosakwe/vim-flutter', { 'for': 'dart' }
Plug 'PotatoesMaster/i3-vim-syntax', { 'for': 'config' }
Plug 'lervag/vimtex', { 'for': 'tex' } " adds tex functionality
	let g:tex_flavor='latex'
	let g:vimtex_view_method='zathura'
	let g:vimtex_quickfix_mode=0
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
	set conceallevel=2
	let g:tex_conceal="abdgm"
Plug 'editorconfig/editorconfig-vim' " allows multiple style settings based on filetype
	let g:EditorConfig_exclude_patterns = ['scp://.\*']
Plug 'ludovicchabant/vim-gutentags'
Plug 'liuchengxu/vista.vim'
Plug 'mbbill/undotree'
Plug 'junegunn/goyo.vim' " nice prose writing
Plug 'RRethy/vim-hexokinase' " Adds colored boxes to hex codes
	let g:Hexokinase_highlighters = ['foregroundfull']
	let g:Hexokinase_optInPatterns = ['full_hex', 'triple_hex', 'rgb', 'rgba', 'colour_names']
	let g:Hexokinase_refreshEvents = ['BufWritePost']
	let g:Hexokinase_ftAutoload = ['*']
" Plug 'eslint/eslint' " javascript linter
" Plug 'segeljakt/vim-isotope'
Plug 'axvr/photon.vim' " adds multiple color schemes
Plug 'joshdick/onedark.vim'
Plug 'ananagame/vimsence' " Discord rich presence
call plug#end()

" Some basics:
	filetype plugin on
	syntax on
	set number relativenumber
	set encoding=utf-8
	set updatetime=100
	if (has("termguicolors"))
		set termguicolors
	endif

" toggle absolute/relative number
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" <tab> triggers coc completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

