augroup binds
	autocmd!
	autocmd BufWrite	*.agda	CornelisLoad
augroup END

set expandtab
set shiftwidth=2
set tabstop=2

let g:easy_align_delimiters = {
\ 'r': { 'pattern': '[≤≡≈∎]', 'left_margin': 2, 'right_margin': 0 },
\ }

inoremap \\ <c-o>:call cornelis#prompt_input()<CR>

nnoremap <c-c><c-space> <cmd>CornelisGive<CR>
nnoremap <c-c><c-c> <cmd>CornelisMakeCase<CR>
nnoremap <c-c><c-m> <cmd>CornelisQuestionToMeta<CR>
nnoremap <c-c><c-d> <cmd>CornelisTypeInfer<CR>
nnoremap <c-c><c-.> <cmd>CornelisTypeContextInfer<CR>
nnoremap <c-c><c-n> <cmd>CornelisNormalize<CR>
nnoremap <c-c><c-r> <cmd>CornelisRefine<CR>

nnoremap <c-a> <cmd>CornelisInc<CR>
nnoremap <c-x> <cmd>CornelisDec<CR>

nnoremap <buffer> gd <cmd>CornelisGoToDefinition<CR>
nnoremap <buffer> K <cmd>CornelisWhyInScope<CR>
nnoremap <buffer> <leader>a <cmd>CornelisAuto<CR>
nnoremap <buffer> g[ <cmd>CornelisPrevGoal<CR>
nnoremap <buffer> g] <cmd>CornelisNextGoal<CR>

call cornelis#bind_input("mid", "·")
call cornelis#bind_input("p1", "proj₁")
call cornelis#bind_input("p2", "proj₂")
call cornelis#bind_input("rt", "⊢")
call cornelis#bind_input("rtt", "⊨")
call cornelis#bind_input(",", "⸴")
call cornelis#bind_input("check", "✓")

