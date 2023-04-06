augroup binds
	autocmd!
	autocmd BufWrite	*.agda	CornelisLoad
augroup END

set expandtab
set shiftwidth=2
set tabstop=2

inoremap \\ <c-o>:call cornelis#prompt_input()<CR>
