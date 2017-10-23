set guifont=Inconsolata\ for\ Powerline:h14
set guioptions-=T
set guioptions-=R
set guioptions-=r
set guioptions-=l
set guioptions-=L

macm File.New\ Tab key=<NOP>
macm File.Close key=<NOP>
nmap <S-Enter> O<Esc>j

nnoremap <D-w> :bd<CR>

nnoremap <silent> ˇ <C-w>h
nnoremap <silent> ¯ <C-w>j
nnoremap <silent> „ <C-w>k
nnoremap <silent> ‘ <C-w>l

colorscheme space-vim-dark
" Make test commands execute using dispatch.vim
let test#strategy = "dispatch"
