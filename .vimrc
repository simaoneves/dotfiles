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
Plug 'w0rp/ale'
Plug 'tpope/vim-abolish'
Plug 'scrooloose/vim-slumlord'
Plug 'RRethy/vim-illuminate'
Plug 'junegunn/vim-peekaboo'
Plug 'FooSoft/vim-argwrap'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'brooth/far.vim'
Plug 'rstacruz/vim-xtract'

" Language specific
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mxw/vim-jsx'
Plug 'rhysd/vim-crystal'
Plug 'suan/vim-instant-markdown'
Plug 'ekalinin/Dockerfile.vim'
Plug 'aklt/plantuml-syntax'
Plug 'udalov/kotlin-vim'
Plug 'dzeban/vim-log-syntax'
Plug 'mustache/vim-mustache-handlebars'

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
Plug 'ayu-theme/ayu-vim'
Plug 'jnurmine/Zenburn'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'arcticicestudio/nord-vim'
Plug 'bluz71/vim-moonfly-colors'

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
Plug 'AndrewRadev/dsf.vim'
Plug 'Julian/vim-textobj-variable-segment'

call plug#end()
filetype plugin indent on    " required

"""""""""""""""""""""""
" Plugin configurations
"""""""""""""""""""""""
" Update preview only on save
let g:instant_markdown_slow = 1
" Dont open preview on enter mardown file
let g:instant_markdown_autostart = 0
" Disable automatic mappings from vim-move plugin
let g:move_map_keys = 0
let g:spring_night_high_contrast = 0
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
let g:hybrid_custom_term_colors = 1
" Show modified indicator in bufline
let g:buftabline_indicators = 1
" Show dotfiles in NERDTree
let NERDTreeShowHidden = 1
" JSX indenting and syntax doesnt require .jsx extensions
let g:jsx_ext_required = 0
let g:switch_mapping = "-"
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --vimgrep --hidden --ignore "tags" --ignore ".git/"'

endif
" Make test commands execute using vimux
let test#strategy = "vimux"

" Use docker-compose to run tests if we are using containers
function! DockerTransformation(cmd) abort
    if filereadable('build.gradle')
        return a:cmd
    endif
    if filereadable('package.json')
        return a:cmd
    endif
    if filereadable('docker-compose.yml')
        return 'docker-compose run tests '.a:cmd
    endif
    return a:cmd
endfunction
let g:test#custom_transformations = {'docker': function('DockerTransformation')}
let g:test#transformation = 'docker'

" Time in miliseconds before highlight other occurences of word under cursor
let g:Illuminate_delay = 300
" Make sure the highlighted occurences of the word under the cursor are visible
highlight link illuminatedWord Visual

" Change color and char of indent lines
let g:indentLine_setColors = 1
let g:indentLine_char = '¦'

" Define Emmet key
let g:user_emmet_leader_key='<C-g>'

" Set delay so that it doesn't open the window automatically
let g:peekaboo_delay = 250
" Adjust the window that opens with the registers
let g:peekaboo_window = 'vertical botright 100new'

" Add comma when unwrapping arguments
let g:argwrap_tail_comma = 1

" ALE
" Solves bug: ":h ale-completion-completeopt-bug"
set completeopt=menu,menuone,preview,noselect,noinsert
" Update signs used in gutter, as well as the colors
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
" Delay in miliseconds until ale completion kicks in
let g:ale_completion_delay = 50
" Only run ALE on save
let g:ale_lint_on_text_changed = 'never'
" Enable linter on enter
let g:ale_lint_on_enter = 1
" Let ALE use LSP for auto-completion
let g:ale_completion_enabled = 1
" Configured linters and fixers
let g:ale_linters = {
\   'ruby': ['rubocop', 'solargraph'],
\   'kotlin': ['languageserver'],
\   'crystal': ['crystalline'],
\   'javascript': ['tsserver', 'eslint'],
\   'typescript': ['tsserver', 'eslint'],
\   'typescriptreact': ['tsserver', 'eslint']
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\}

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
set omnifunc=ale#completion#OmniFunc

" Customize fzf colors to match color scheme
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

let g:fzf_layout = { 'down': '40%' }

" Customize projections for javascript projects
let g:projectionist_heuristics = {
      \   "src/|package.json": {
      \       "src/*.js": { "alternate": "src/{}.spec.js" },
      \       "src/*.jsx": { "alternate": "src/{}.spec.jsx" },
      \       "src/*.spec.js": { "alternate": "src/{}.js" },
      \       "src/*.spec.jsx": { "alternate": "src/{}.jsx" },
      \       "src/*.ts": { "alternate": "src/{}.test.ts" },
      \       "src/*.tsx": { "alternate": "src/{}.test.tsx" },
      \       "src/*.test.ts": { "alternate": "src/{}.ts" },
      \       "src/*.test.tsx": { "alternate": "src/{}.tsx" },
      \   },
      \   "lib/|Gemfile": {
      \       "spec/unit/*_spec.rb": { "alternate": "lib/{}.rb" },
      \       "spec/integration/*_spec.rb": { "alternate": "lib/{}.rb" },
      \       "spec/acceptance/*_spec.rb": { "alternate": "lib/{}.rb" },
      \       "lib/*.rb": { "alternate": "spec/unit/{}_spec.rb" },
      \       "lib/central/*.rb": { "alternate": "spec/unit/{}_spec.rb" },
      \       "spec/unit/web/*_spec.rb": { "alternate": "web/{}.rb" },
      \       "web/*.rb": { "alternate": "spec/unit/web/{}_spec.rb" }
      \   },
      \   "build.gradle": {
      \       "src/main/kotlin/*.kt": {"alternate": "src/test/kotlin/{}Test.kt"},
      \       "src/test/kotlin/*Test.kt": {"alternate": "src/main/kotlin/{}.kt"},
      \   },
      \ }

" Bugged for now in Macvim
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': '--preview "bat -p --theme=gruvbox-dark --color=always {}"' }, <bang>0)

" Trigger keys for next position in snippet
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

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
colorscheme gruvbox
set background=dark
set re=1
" Use both relative and normal line numbers
set relativenumber
set number
" Use mouse for selecting panes and scrolling
set mouse=n
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
" Dont load shell enviroment when running commands, or else moving to a tmux
" pane is super slow
set shell=/bin/bash\ -i

function! StatuslineGit()
  let l:branchname = fugitive#head()
  return strlen(l:branchname) > 0 ? '  '.l:branchname : ''
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:spelling = all_errors == 1 ? '' : 's'

    return l:all_errors == 0 ? '' : printf(' ✗ %d error%s found ', all_errors, spelling)
endfunction

set statusline=
set statusline+=\ [%{mode()}] " Mode
set statusline+=\ %F " Filename
set statusline+=%m " Modifiable
set statusline+=%= " Seperation between left and right side
set statusline+=\ %c:%L " Line number and column
set statusline+=%{StatuslineGit()}
set statusline+=\ %y " Filetype
set statusline+=\ %#Error# " use Error highlight group
set statusline+=%{LinterStatus()}
set statusline+=%* "return to default color
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

" Use Tab key for trigger completion, selection and snippet expand
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" C-j and C-k for autocompletion.
inoremap <expr><C-j>  pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k>  pumvisible() ? "\<C-p>" : "\<C-k>"

" Use C-h and C-l to change buffers
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>
imap <C-l> <Esc>:bn<CR>
imap <C-h> <Esc>:bp<CR>

" Use Space-Space to Hover with ALE
nnoremap <silent> <Leader><Leader> :ALEHover<CR>

" Bubble selections up and down
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp
nmap <C-j> <Plug>MoveLineDown
nmap <C-k> <Plug>MoveLineUp

" Dont use linewise motions
nmap j gj
nmap k gk

" Move by word in command line mode
cmap b <S-Left>
cmap f <S-Right>

" Argument wrapping
nnoremap <silent> <Leader>aw :ArgWrap<CR>

" Change ReplaceWithRegister default mapping
nmap <C-p> gr

" Change insert surround shortcut, from vim-surround
nmap <C-s> ys
vmap <C-s> S

" bind ? to grep word under cursor
nnoremap ? :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Put cursor on the middle of the screen after moving
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
" Select last pasted text
nmap gV '[v']'
" No more Ex mode please
nnoremap Q <Nop>

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
" Open bufers
nmap <Leader>b :Buffer<CR>
" Move to last buffer and close the one we were on
nmap <Leader>w :bp<CR>:bd #<CR>
" Jump to definition (uses tags)
nmap <Leader>j <C-]>

" Open current word as a tag in a new horizontal split
nmap <Leader>J :sp <CR>:exec("tag ".expand("<cword>"))<CR>
" Find and replace word under cursor in file
nmap <Leader>fr :%s/<C-R><C-W>//<Left>

" Find what is in the search register and replace with what is in the
" clipboard, inside a selection
vmap <Leader>fr :s/<C-R>//<C-R>*/<Left>
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
" Find the current file in NERDTree
nmap <Leader>\ :NERDTreeFind<CR>
" Close all buffers
nnoremap <Leader>Qa :bufdo bd<CR>
" Emmet expand abbr
nmap <Leader>e <C-g>,
" Cycle between results
nmap <Leader>n :cn<CR>
nmap <Leader>p :cp<CR>
" Open alternate file in a vertical split
nmap <Leader>va :AV<CR>
" Open alternate file
nmap <Leader>a :A<CR>
" Open tags in current file
nmap <Leader>r :Tags<CR>
" Find project wide
nmap <Leader>f :Ack!<Space>""OD
" Find project wide with what is in the clipboard
nmap <Leader>F :Ack! """<CR>
" Find references for word under the cursor
nmap <Leader>l :ALEFindReferences<CR>
" Fuzzy Finder, with preview
nmap <Leader>t :Files<CR>
" Run tests for current file
nmap <Leader>rt :TestFile<CR>
" Whose fault is this mess?
nmap <Leader>B :Gblame<CR>
" Run all tests
nmap <Leader>ra :TestSuite<CR>
" Run Test in this line
nmap <Leader>rn :TestNearest<CR>
" Close pane used by Vimux
nmap <Leader>cr :VimuxCloseRunner<CR>
" Run custom command
nmap <Leader>vp :VimuxPromptCommand<CR>
" Zoom in on the tmux pane
nmap <Leader>zr :VimuxZoomRunner<CR>
" Run last command with Vimux
nmap <Leader>rr :VimuxRunLastCommand<CR>
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

" Update GitGutter on save
autocmd BufWritePost * GitGutter

" This helps if there was any change to buffer, to be used with autoread
autocmd CursorHold * checktime

" Kotlin settings
autocmd FileType kotlin call SetAlternativeColorscheme()
function! SetAlternativeColorscheme()
    colorscheme one
endfunction

" Ruby and Crystal settings
autocmd FileType ruby,eruby,crystal call SetTwoSpacesSettings()
function! SetTwoSpacesSettings()
    match errormsg '\%>110v.\+'
    set tabstop=2 shiftwidth=2 softtabstop=2
endfunction

" Show me the all the quotes in JSON please
autocmd BufEnter,BufCreate,BufNew,BufNewFile,BufAdd *.json call ShowMeTheQuotesPlease()
function! ShowMeTheQuotesPlease()
    set conceallevel=0
endfunction

" Use ALEGoToDefinition and Next/Previous error
autocmd FileType typescript.tsx,typescript,javascript,typescriptreact call ChangeJumpToDefinition()
function! ChangeJumpToDefinition()
    nmap <Leader>j :ALEGoToDefinition<CR>
    nmap <Leader>n <Plug>(ale_previous_wrap)
    nmap <Leader>p <Plug>(ale_next_wrap)
endfunction

" Add error color for lines greater than 72 chars in gitcommit
autocmd FileType gitcommit call SetColorColumnAfter72Chars()
function! SetColorColumnAfter72Chars()
    match errormsg '\%>72v.\+'
endfunction

" Complement TAB key in insert-mode (comes from coc-snippets)
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! OpenCommandInPopWindow(width, height, border_highlight) abort
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    call inputsave()
    let cmd = input('Enter command: ')
    call inputrestore()
    let bufnr = term_start(cmd, {'hidden': 1, 'term_finish': 'close', 'cwd': getcwd()})

    let winid = popup_create(bufnr, {
            \ 'minwidth': width,
            \ 'maxwidth': width,
            \ 'minheight': height,
            \ 'maxheight': height,
            \ 'border': [],
            \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
            \ 'borderhighlight': [a:border_highlight],
            \ 'padding': [0,1,0,1],
            \ 'highlight': a:border_highlight
            \ })

    " Optionally set the 'Normal' color for the terminal buffer
    call setwinvar(winid, '&wincolor', 'Special')

    return winid
endfunction

map <silent> <Leader>gp :call OpenCommandInPopWindow(0.9,0.6,'Todo')<CR>

" autogroup to track last open buffer
augroup bufclosetrack
  au!
  autocmd WinLeave * let g:lastWinName = @%
augroup END
function! LastWindow()
  exe "split " . g:lastWinName
endfunction
command -nargs=0 LastWindow call LastWindow()
map <silent> <Leader>T :call LastWindow()<CR>

" This must be the last thing in vimrc for some weird reason
" Auto reload vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    if has("gui_running")
        source ~/.gvimrc
    endif
augroup END

