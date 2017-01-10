set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.Vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/vitality.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'

call vundle#end()            " required
filetype plugin indent on    " required

syntax enable

" colorscheme hybrid
colorscheme base16-ocean
set background=dark
set relativenumber
set number
set autoindent
set so=6

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
" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" JSX indenting and syntax doesnt require .jsx extensions
let g:jsx_ext_required = 0

" Not show original status line
set noshowmode

" Show highlight current line
set cursorline

let mapleader=","
set timeout timeoutlen=1500

" Use system clipboard
set clipboard=unnamed

nmap <C-w> :bd<CR>
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>
nmap <C-s> :w<CR>
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap ,e :e ~/.vimrc<CR>

set lazyredraw
set ttyfast " u got a fast terminal
" set ttyscroll=3

