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
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'kana/vim-textobj-user'
Plugin 'glts/vim-textobj-comment'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-indent'
Plugin 'sgur/vim-textobj-parameter'
Plugin 'beloglazov/vim-textobj-quotes'
Plugin 'Julian/vim-textobj-brace'
Plugin 'tek/vim-textobj-ruby'
Plugin 'tpope/vim-commentary'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'AndrewRadev/switch.vim'
Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'benmills/vimux'
Plugin 'Shougo/neocomplete.vim'

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
set timeoutlen=1500
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
let g:ctrlp_map = '<C-ç>'
" JSX indenting and syntax doesnt require .jsx extensions
let g:jsx_ext_required = 0
let g:switch_mapping = "-"
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Not show original status line
set noshowmode

" Show highlight current line
set cursorline

let mapleader=" "
set timeout

" Use system clipboard
set clipboard=unnamed

" Use tab completion in exmode
set wildmenu

set hidden

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --vimgrep'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" ˇ¯„‘
" Use M-hjkl to change splits
" nmap ˇ <C-w><C-h>
" nmap ¯ <C-w><C-j>
" nmap „ <C-w><C-k>
" nmap ‘ <C-w><C-l>

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> ˇ :TmuxNavigateLeft<cr>
nnoremap <silent> ¯ :TmuxNavigateDown<cr>
nnoremap <silent> „ :TmuxNavigateUp<cr>
nnoremap <silent> ‘ :TmuxNavigateRight<cr>
"
" Tab and shift-Tab completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr>^[[Z  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Use C-h and l to change buffers
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>

" Change ReplaceWithRegister default mapping
nmap <C-p> gr

" bind K to grep word under cursor
nnoremap ? :Ack "\b<C-R><C-W>\b"<CR>:cw<CR>

" Put cursor on the middle of the screen after moving
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz

" Mappings made in iTerm2, so i can use Cmd key
nmap openLineAbove O<Esc>j
nmap saveBuffer :w<CR>
nmap <CR> o<Esc>k

" Close buffer
nmap <Leader>w :bd<CR>
" Jump to definition (uses tags)
nmap <Leader>j <C-]>
" Edit this file
nmap <Leader>e :e ~/.vimrc<CR>
" Toggle NERDTree
nmap <C-\> :NERDTreeToggle<CR>
" Open tags in current file
nmap <Leader>r :CtrlPBufTag<CR>

" Find project wide
nmap <Leader>f :Ack<Space>

" Fuzzy Finder
nmap <Leader>t :FZF<CR>
" Run last command with Vimux
nmap <Leader>rl :VimuxRunLastCommand<CR>
" Run (NPM) tests
nmap <Leader>rt :call VimuxRunCommand("clear; nt")<CR>
" Close pane used by Vimux
nmap <Leader>cr :VimuxCloseRunner<CR>
" Run custom command
nmap <Leader>dc :VimuxPromptCommand<CR>

" Add FZF to the runtimepath
set rtp+=/usr/local/opt/fzf

" Tag files definition
set tags=./tags;/
set lazyredraw
" Indicate fast terminalsaveBuffer:b
set ttyfast 
set ttyscroll=3
" Number of colors in the terminal
set t_Co=256

" Auto reload vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
