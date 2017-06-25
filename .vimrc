set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.Vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/vitality.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'Raimondi/delimitMate'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'AndrewRadev/switch.vim'
Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'benmills/vimux'
Plugin 'Shougo/neocomplete.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Language specific
Plugin 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plugin 'mxw/vim-jsx'
Plugin 'rhysd/vim-crystal'

" Themes
Plugin 'dracula/vim'
Plugin 'chriskempson/base16-vim'
Plugin 'rhysd/vim-color-spring-night'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'MaxSt/FlatColor'
Plugin 'rakr/vim-one'
Plugin 'liuchengxu/space-vim-dark'

" Text objects and operators
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-operator-user'
Plugin 'glts/vim-textobj-comment'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-indent'
Plugin 'sgur/vim-textobj-parameter'
Plugin 'beloglazov/vim-textobj-quotes'
Plugin 'Julian/vim-textobj-brace'
Plugin 'tek/vim-textobj-ruby'
Plugin 'tpope/vim-commentary'
Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'tpope/vim-surround'
Plugin 'haya14busa/vim-operator-flashy'

call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""
let g:airline_theme = "wombat"
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
let NERDTreeShowHidden = 1
let g:ctrlp_map = '<C-ç>'
" JSX indenting and syntax doesnt require .jsx extensions
let g:jsx_ext_required = 0
let g:switch_mapping = "-"
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --vimgrep --hidden --ignore "tags"'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor --ignore "tags" -g ""'
endif

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

""""""""""""""""""""
" Vim configurations
""""""""""""""""""""
syntax enable
" Show highlight current line
set cursorline
set timeout
" Use system clipboard
set clipboard=unnamed
" Use correct behaviour for backspace
set backspace=indent,eol,start
" Use tab completion in exmode
set wildmenu
" Not show original status line
set noshowmode
set hidden
set termguicolors
set noswapfile
colorscheme one
set background=dark
set relativenumber
set number
set autoindent
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set so=6
" Search with case insensive, unless it has a capital letter in it
set smartcase
set encoding=utf-8
set laststatus=2
set timeoutlen=1500
" Open splits where they should
set splitbelow
set splitright
" Add FZF to the runtimepath
set rtp+=/usr/local/opt/fzf
" Tag files definition
set tags=./tags;/
set lazyredraw
" Indicate fast terminal
set ttyfast 
set ttyscroll=3
" Number of colors in the terminal
set t_Co=256
" Dont move the cursor to the beggining of the line every time we do something
set nostartofline
" Hightlight search for default
set hlsearch

"""""""""""""""""""""""
" Keymap configurations
"""""""""""""""""""""""
let mapleader=" "
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> ˇ :TmuxNavigateLeft<cr>
nnoremap <silent> ¯ :TmuxNavigateDown<cr>
nnoremap <silent> „ :TmuxNavigateUp<cr>
nnoremap <silent> ‘ :TmuxNavigateRight<cr>
" C-j and C-k for autocompletion.
inoremap <expr><C-j>  pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k>  pumvisible() ? "\<C-p>" : "\<C-k>"
" Use C-h and l to change buffers
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>
imap <C-l> <Esc>:bn<CR>
imap <C-h> <Esc>:bp<CR>
" Dont use linewise motions
nmap j gj
nmap k gk
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
" Move to last buffer and close the one we were one buffer
nmap <Leader>w :bp<CR>:bd #<CR>
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
nmap <Leader>rr :VimuxRunLastCommand<CR>
" Run (NPM) tests
nmap <Leader>rt :call VimuxRunCommand("clear; nt")<CR>
" Close pane used by Vimux
nmap <Leader>cr :VimuxCloseRunner<CR>
" Run custom command
nmap <Leader>dc :VimuxPromptCommand<CR>
" Zoom in on the tmux pane
nmap <Leader>zr :VimuxZoomRunner<CR>
" Flash text on yank
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
" Fix autoindent while pasting
map p ]p
map P ]P

" Auto reload vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
