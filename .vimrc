set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.Vim'
Plugin 'chriskempson/base16-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/vitality.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'dracula/vim'
Plugin 'rhysd/vim-crystal'
Plugin 'rhysd/vim-color-spring-night'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set noswapfile
colorscheme base16-eighties
set background=dark
set relativenumber
set number
set autoindent
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set so=6
set encoding=utf-8

set laststatus=2
set timeoutlen=50
let g:airline_theme = "base16_eighties"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_right_sep = ''
let g:airline_left_sep = ''
let g:airline_powerline_fonts = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
let g:hybrid_custom_term_colors = 1
let g:ctrlp_extensions = ['buffertag']
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_working_path_mode = 'r'
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

" Use tab completion in exmode
set wildmenu

set hidden

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use C-hjkl to change splits
nmap <C-l> <C-w><C-l>
nmap <C-k> <C-w><C-k>
nmap <C-h> <C-w><C-h>
nmap <C-j> <C-w><C-j>

" Use L and H to change buffers
nmap L :bn<CR>
nmap H :bp<CR>

" 
nmap <C-s> :w<CR>
nmap <C-s> :w<CR>

" bind K to grep word under cursor
nnoremap ? :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Put cursor on the middle of the screen after moving
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz

" Bubble lines up and down (weird characters are <A-j> and <A-k> in my
" terminal
nmap ¯ ddp
nmap „ ddkP

nmap openLineAbove O<Esc>j
nmap <CR> o<Esc>k

nmap ,e :e ~/.vimrc<CR>
nmap <C-\> :NERDTreeToggle<CR>

set rtp+=/usr/local/opt/fzf

set tags=./tags;/
set lazyredraw
set ttyfast " u got a fast terminal
set ttyscroll=3
