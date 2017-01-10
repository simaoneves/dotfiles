execute pathogen#infect()

syntax enable

" colorscheme hybrid
colorscheme base16-gooey
set background=dark
set relativenumber
set number
set autoindent
set so=6
filetype plugin on

set laststatus=2
let g:airline_powerline_fonts = 1
set timeoutlen=50
let g:airline_theme = "base16"
let g:airline#extensions#tabline#enabled = 1
let g:airline_right_sep = ''
let g:airline_left_sep = ''
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
let g:hybrid_custom_term_colors = 1
let g:ctrlp_extensions = ['buffertag']

" not show original status line
set noshowmode

" show highlight current line
set cursorline

let mapleader=","
set timeout timeoutlen=1500

nmap <C-w> :bd<CR>
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>
nmap <C-s> :w<CR>
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap ,e :e ~/.vimrc<CR>

set lazyredraw
set ttyfast " u got a fast terminal
set ttyscroll=3

