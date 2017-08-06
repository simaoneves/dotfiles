" set guifont=Inconsolata\ for\ Powerline:h14
set guifont=Inconsolata\ for\ Powerline:h14
set guioptions-=T
set guioptions-=R
set guioptions-=r
set guioptions-=l
set guioptions-=L

macm File.New\ Tab key=<NOP>
macm File.New\ Tab key=<NOP>
macm File.Close key=<NOP>
nmap <S-Enter> O<Esc>j

nnoremap <D-t> :CtrlP<CR>
nnoremap <Leader>t :CtrlP<CR>
nnoremap <D-r> :CtrlPFunky<CR>
nnoremap <D-w> :bd<CR>

nnoremap <silent> ˇ <C-w>h
nnoremap <silent> ¯ <C-w>j
nnoremap <silent> „ <C-w>k
nnoremap <silent> ‘ <C-w>l

colorscheme spring-night
let g:airline_theme = "spring_night"
