set textwidth=95
set formatoptions+=t
set tabstop=4
set shiftwidth=4
" let g:tex_flavor='latex'

let b:images_folder = simplify(expand('%:p:h') . '/images/')
let b:ScreenShotCommand = '~/.config/nvim/ftplugin/tex_screenshot.sh ' . b:images_folder

nmap <c-f> :exec "read! ".b:ScreenShotCommand<CR>

