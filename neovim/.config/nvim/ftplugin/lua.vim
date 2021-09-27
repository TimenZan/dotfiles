set tabstop=4
set expandtab
set shiftwidth=4

augroup lua_save
	autocmd!
	autocmd BufWrite *.lua call LuaFormat()
augroup!
