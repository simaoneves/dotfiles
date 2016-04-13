syntax enable

colorscheme hybrid
set background=dark
set relativenumber
set number
set autoindent
set so=12

set laststatus=2
let g:airline_powerline_fonts = 1
set timeoutlen=50
let g:airline_theme = "base16_default"
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
let g:hybrid_custom_term_colors = 1

" not show original status line
set noshowmode
" show highlight current line
set cursorline
set lazyredraw 
set ttyfast " u got a fast terminal
set ttyscroll=3
