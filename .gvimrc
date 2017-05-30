set guifont=Fira\ Mono\ Medium\ for\ Powerline:h12
set guioptions-=T
set guioptions-=R
set guioptions-=r
set guioptions-=l
set guioptions-=L

macm File.New\ Tab key=<nop>
macm File.New\ Tab key=<nop>
macm File.Close key=<nop>
nmap <S-Enter> O<Esc>j

nnoremap <D-t> :CtrlP<CR>
nnoremap <D-r> :CtrlPFunky<CR>
nnoremap <D-w> :bd<CR>

colorscheme spring-night
let g:airline_theme = "spring_night"