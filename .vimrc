set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'sjl/vitality.vim'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Raimondi/delimitMate'
Plug 'christoomey/vim-tmux-navigator'
Plug 'AndrewRadev/switch.vim'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf.vim'
Plug 'benmills/vimux'
Plug 'Shougo/neocomplete.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'teranex/jk-jumps.vim'
Plug 'Yggdroot/indentLine'
Plug 'matze/vim-move'
Plug 'rhysd/committia.vim'
Plug 'mattn/emmet-vim'
Plug 'janko-m/vim-test'
Plug 'ap/vim-buftabline'
Plug 'natebosch/vim-lsc'

" Language specific
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx'
Plug 'rhysd/vim-crystal'
Plug 'tpope/vim-rails'
Plug 'suan/vim-instant-markdown'

" Themes
Plug 'dracula/vim'
Plug 'chriskempson/base16-vim'
Plug 'rhysd/vim-color-spring-night'
Plug 'MaxSt/FlatColor'
Plug 'rakr/vim-one'
Plug 'liuchengxu/space-vim-dark'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'trevordmiller/nova-vim'

" Text objects and operators
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-operator-user'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'sgur/vim-textobj-parameter'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'tek/vim-textobj-ruby'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-surround'
Plug 'haya14busa/vim-operator-flashy'

call plug#end()
filetype plugin indent on    " required

"""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""
" Update preview only on save
let g:instant_markdown_slow = 1
" Dont open preview on enter mardown file
let g:instant_markdown_autostart = 0
" Buble lines up and down with Ctrl
let g:move_key_modifier = 'C'
let g:spring_night_high_contrast = []
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
let g:hybrid_custom_term_colors = 1
let g:ctrlp_extensions = ['buffertag']
" Show modified indicator in bufline
let g:buftabline_indicators = 1
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_working_path_mode = 'r'
" Show dotfiles in NERDTree
let NERDTreeShowHidden = 1
let g:ctrlp_map = '<C-ç>'
let g:UltiSnipsExpandTrigger="<NOP>"
let g:UltiSnipsJumpForwardTrigger="<NOP>"
let g:UltiSnipsJumpBackwardTrigger="<NOP>"
" JSX indenting and syntax doesnt require .jsx extensions
let g:jsx_ext_required = 0
let g:switch_mapping = "-"
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --vimgrep --hidden --ignore "tags" --ignore ".git/"'
endif
" Make test commands execute using vimux
let test#strategy = "vimux"
" Register Language Servers
let g:lsc_server_commands = {
    \ 'ruby': 'language_server-ruby',
    \ 'crystal': 'scry',
    \ }
"\ 'javascript.jsx': 'node /usr/local/bin/javascript-typescript-langserver/lib/language-server-stdio'

let g:lsc_auto_map = v:true " Use defaults
" Change color and char of indent lines
let g:indentLine_setColors = 1
let g:indentLine_char = '¦'

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

" Customize projections for javascript projects
let g:projectionist_heuristics = {
      \   "app/|package.json": {
      \       "app/components/*.js": { "alternate": "app/styles/{}.js" },
      \       "app/styles/*.js": { "alternate": "app/components/{}.js" },
      \       "app/components/screens/*Screen.js": { "alternate": "app/styles/screens/{}.js" },
      \       "app/styles/screens/*.js": { "alternate": "app/components/screens/{}Screen.js" },
      \       "test/*Spec.js": { "alternate": "app/{}.js" },
      \       "spec/*.spec.js": { "alternate": "app/{}.js" }
      \   }
      \ }

" Bugged for now in Macvim
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({ 'options': '--preview "pygmentize {}"' }), <bang>0)

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
" set noshowmode
set hidden
set noswapfile
if !has("gui_running")
    set termguicolors
    " Number of colors in the terminal
    set t_Co=256
    set term=xterm-256color
endif
colorscheme space-vim-dark
set background=dark
" Use both relative and normal line numbers
set relativenumber
set number
set autoindent
" Expand Tabs to spaces
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set so=6
" When a file changes outside of vim, reload it automatically
set autoread
" Apply substitutions globally by default (no need to use g)
set gdefault
" Search with case insensive, unless it has a capital letter in it
set smartcase
set encoding=utf-8
set laststatus=2
set timeoutlen=450
set ttimeoutlen=0
" Open splits where they should
set splitbelow
set splitright
" Add FZF to the runtimepath
set rtp+=/usr/local/opt/fzf
" Tag files definition
set tags=./tags;/
" Dont redraw the screen when replaying macros
set lazyredraw
" Indicate fast terminal
set ttyfast
set ttyscroll=3
" Dont move the cursor to the beggining of the line every time we do something
set nostartofline
" Hightlight search for default
set hlsearch
" Highlight search while typing
set incsearch
" Load shell enviroment when running commands
" set shell=bash\ -l

function! StatuslineGit()
  let l:branchname = fugitive#head()
  return strlen(l:branchname) > 0 ? '  '.l:branchname : ''
endfunction

set statusline=
set statusline+=\ [%{mode()}] " Mode
set statusline+=\ %f " Filename
set statusline+=%m " Modifiable
set statusline+=%=
set statusline+=\ %c:%L " Line number and column
set statusline+=%{StatuslineGit()}
set statusline+=\ %y " Filetype
set statusline+=\ %{&fileencoding?&fileencoding:&encoding} " File encoding
set statusline+=\[%{&fileformat}\] " File format
set statusline+=\ 

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
inoremap <expr><Tab>  pumvisible() ? "\<C-R>=UltiSnips#ExpandSnippet()<CR>" : "\<Tab>"
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
" bind ? to grep word under cursor
nnoremap ? :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
" Put cursor on the middle of the screen after moving
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
" Select last pasted text
nmap gV '[v']'
" Mappings made in iTerm2, so i can use Cmd key
nmap openLineAbove O<Esc>j
nmap saveBuffer :w<CR>
imap saveBuffer <esc>:w<CR>
vmap saveBuffer <esc>:w<CR>gv
nmap <CR> o<Esc>k
" Indent using tab in visual mode
vnoremap <Tab> >gv
vmap <S-Tab> <gv
" Indent using tab in normal mode
nmap <Tab> >>
nmap <S-Tab> <<
" Close quickfix
nmap <Leader>cc :cclose<CR>
" Move to last buffer and close the one we were one buffer
nmap <Leader>w :bp<CR>:bd #<CR>
" Jump to definition (uses tags)
nmap <Leader>j <C-]>
" Copy paragraph below
nmap <Leader>cp yap}p
" Edit this file
nmap <Leader>, :e ~/.vimrc<CR>
" Edit stuff file
nmap <Leader>D :e ~/Documents/stuff<CR>
" Turn highlight off
nmap <silent> <Leader>0 :noh<cr>
" Toggle NERDTree
nmap <C-\> :NERDTreeToggle<CR>
" Close all buffers
nnoremap <Leader>Qa :bufdo bd<CR>
" Open alternate file in a vertical split
nmap <Leader>a :AV<CR>
" Open tags in current file
nmap <Leader>r :Tags<CR>
" Find project wide
nmap <Leader>f :Ack!<Space>
" Fuzzy Finder, with preview
nmap <Leader>t :FZF<CR>
" Run last command with Vimux
nmap <Leader>rr :VimuxRunLastCommand<CR>
" Run tests for current file
nmap <Leader>rt :TestFile<CR>
" Run all tests
nmap <Leader>ra :TestSuite<CR>
" Close pane used by Vimux
nmap <Leader>cr :VimuxCloseRunner<CR>
" Run custom command
nmap <Leader>dc :VimuxPromptCommand<CR>
" Zoom in on the tmux pane
nmap <Leader>zr :VimuxZoomRunner<CR>
" Flash text on yank
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
" Shortcut to 'tabs'
nmap <Leader>1 <Plug>BufTabLine.Go(1)
nmap <Leader>2 <Plug>BufTabLine.Go(2)
nmap <Leader>3 <Plug>BufTabLine.Go(3)
nmap <Leader>4 <Plug>BufTabLine.Go(4)
nmap <Leader>5 <Plug>BufTabLine.Go(5)
nmap <Leader>6 <Plug>BufTabLine.Go(6)
nmap <Leader>7 <Plug>BufTabLine.Go(7)
nmap <Leader>8 <Plug>BufTabLine.Go(8)
nmap <Leader>9 <Plug>BufTabLine.Go(9)
" Resize windows using arrow keys
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

" Ruby and Crystal settings
autocmd FileType ruby,eruby,crystal call SetTwoSpacesSettings()
function! SetTwoSpacesSettings()
    match errormsg '\%>100v.\+'
    set tabstop=2 shiftwidth=2 softtabstop=2
endfunction

" Auto reload vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    if has("gui_running")
        source ~/.gvimrc
    endif
augroup END
