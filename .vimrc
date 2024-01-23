set nocompatible              " be iMproved, required
filetype off                  " required

" Auto install Vim-Plug if it doesn't exist
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'sjl/vitality.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'AndrewRadev/switch.vim'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf.vim'
Plug 'benmills/vimux'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'Yggdroot/indentLine'
Plug 'matze/vim-move'
Plug 'rhysd/committia.vim'
Plug 'mattn/emmet-vim'
Plug 'janko-m/vim-test'
Plug 'ap/vim-buftabline'
Plug 'w0rp/ale'
Plug 'tpope/vim-abolish'
Plug 'RRethy/vim-illuminate'
Plug 'junegunn/vim-peekaboo'
Plug 'FooSoft/vim-argwrap'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'romainl/vim-qf' " quickfix list improvement
Plug 'markonm/traces.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/vim-easy-align'
Plug 'github/copilot.vim'

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
" Plug 'simaoneves/kotlin-vim', { 'branch': 'add-highlight' }
Plug 'dzeban/vim-log-syntax'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-rails'
Plug 'rust-lang/rust.vim'

" Themes
Plug 'dracula/vim'
Plug 'Soares/base16.nvim' " has Gooey
Plug 'chriskempson/base16-vim'
Plug 'rhysd/vim-color-spring-night'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'rakr/vim-one'
Plug 'liuchengxu/space-vim-dark'
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'arcticicestudio/nord-vim'
Plug 'bluz71/vim-moonfly-colors'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }

" Text objects and operators
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-operator-user'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'machakann/vim-swap'
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
" Show modified indicator in bufline
let g:buftabline_indicators = 1
" Show dotfiles in NERDTree
let NERDTreeShowHidden = 1
" JSX indenting and syntax doesnt require .jsx extensions
let g:jsx_ext_required = 0
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --vimgrep --hidden --ignore "tags" --ignore ".git/"'
  let g:ackhighlight = 1
  let g:ack_use_dispatch = 1
endif
" Make test commands execute using vimux
let test#strategy = "vimux"

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" Vimux prompt
let g:VimuxPromptString = '❯ '
let g:VimuxOrientation = 'h'
function! ChangeVimuxRunnerPane(index) abort
    let pane = system('tmux list-panes -F "#P #{pane_id}"')
    let pane_id = split(pane, '\n')[a:index]
    let g:VimuxRunnerIndex = split(pane_id, ' ')[1]
endfunction
command -nargs=1 VimuxChangeRunnerPane :call ChangeVimuxRunnerPane(<args>)

" Change gitgutter signs
let g:gitgutter_sign_added = '▍'
let g:gitgutter_sign_modified = '▍'
let g:gitgutter_sign_removed = '▁'

" Use docker-compose to run tests if we are using containers
function! DockerTransformation(cmd) abort
    if filereadable('build.gradle') || filereadable('build.gradle.kts')
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
let g:Illuminate_delay = 200

" Change color and char of indent lines
let g:indentLine_setColors = 1
let g:indentLine_char = '¦'

" Define Emmet key
let g:user_emmet_leader_key='<C-g>'

" Set delay so that it doesn't open the window automatically
let g:peekaboo_delay = 250
" Adjust the window that opens with the registers
let g:peekaboo_window = 'vertical botright 100new'

" Add/remove comma when unwrapping arguments
let g:argwrap_tail_comma = 1
" Add/remove padding space on {}
let g:argwrap_padded_braces = '{'
" Custom Switch definitions
let g:switch_mapping = "-"
let g:switch_find_smallest_match = 1

" Trying to change between multiline and single line blocks
" { |.*| .* }
" into
" do |.*|
"   .*
" end
" autocmd FileType ruby let b:switch_custom_definitions =
"     \ [
"     \   {
"     \     '{\s+\|\(\k\+\)\|\s+\(.*\)\s+}': 'do \|\1\|\n\2\nend',
"     \   },
"     \ ]

let g:switch_custom_definitions =
    \ [
    \   ['foreground', 'background'],
    \   ['vertical', 'horizontal'],
    \   ['standard', 'express'],
    \   ['before', 'after'],
    \   ['next', 'previous'],
    \   ['warning', 'error'],
    \   ['once', 'twice'],
    \   ['width', 'height'],
    \   ['margin', 'padding'],
    \   ['String', '&str'],
    \   ['bottom', 'top'],
    \   ['left', 'right'],
    \   ['start', 'end'],
    \   ['first', 'last'],
    \   ['even', 'odd'],
    \   ['size', 'length'],
    \   ['enable', 'disable'],
    \   ['debug', 'info'],
    \   ['row', 'column'],
    \   ['less', 'more'],
    \   ['upper', 'lower'],
    \   ['get', 'post'],
    \   ['min', 'max'],
    \   ['all', 'none'],
    \   ['if', 'unless'],
    \   ['to', 'not_to'],
    \   ['off', 'on'],
    \   ['up', 'down'],
    \   ['<=', '>='],
    \   ['<', '>'],
    \ ]

" ALE
" Solves bug: ":h ale-completion-completeopt-bug"
set completeopt=menu,menuone,popup,noselect,noinsert
let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
" Update signs used in gutter, as well as the colors
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
" Don't show virtual text with problems all the time
let g:ale_virtualtext_cursor = 0
" Don't Hover all the time, some language servers are slow and this is a blocking operation
let g:ale_hover_cursor = 0
let g:ale_hover_to_floating_preview = 1
let g:ale_floating_preview = 1
" Delay in miliseconds until ale completion kicks in
" Some LSP are slower or faster and the results might be influenced if the
" normal popup opens first
let g:ale_completion_delay = 100
" Only run ALE on save
let g:ale_lint_on_text_changed = 'never'
" Enable linter on enter
let g:ale_lint_on_enter = 1
" Let ALE use LSP for auto-completion
let g:ale_completion_enabled = 1
" Configured linters and fixers
let g:ale_linters = {
\   'rust': ['analyzer'],
\   'ruby': ['sorbet', 'rubocop'],
\   'kotlin': ['languageserver'],
\   'crystal': [],
\   'javascript': ['tsserver', 'eslint'],
\   'typescript': ['tsserver', 'eslint'],
\   'typescriptreact': ['tsserver', 'eslint'],
\   'sh': ['language_server'],
\}
let g:ale_fixers = {
\   'rust': ['rustfmt'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'kotlin': ['ktlint'],
\   'ruby': ['sorbet', 'rubocop'],
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
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Customize FZF layout
let g:fzf_layout = { 'down': '40%' }

" Jump to existing window if possible
let g:fzf_buffers_jump = 1

" Enable commands history with Ctrl-n and Ctrl-p in FZF
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Customize projections for javascript projects
let g:projectionist_heuristics = {
      \   "src/|package.json": {
      \       "src/*.js": { "alternate": "src/{}.spec.js" },
      \       "src/*.jsx": { "alternate": "src/{}.spec.jsx" },
      \       "src/*.spec.js": { "alternate": "src/{}.js" },
      \       "src/*.spec.jsx": { "alternate": "src/{}.jsx" },
      \       "*.ts": { "alternate": "{}.test.ts" },
      \       "*.tsx": { "alternate": "{}.test.tsx" },
      \       "*.test.ts": { "alternate": "{}.ts" },
      \       "*.test.tsx": { "alternate": "{}.tsx" },
      \   },
      \   "lib/|Gemfile": {
      \       "spec/*_spec.rb": { "alternate": "app/{}.rb" },
      \       "app/*.rb": { "alternate": "spec/{}_spec.rb" },
      \   },
      \   "src/|shard.yml": {
      \       "spec/*_spec.cr": { "alternate": "src/{}.cr" },
      \       "src/*.cr": { "alternate": "spec/{}_spec.cr" },
      \   },
      \   "build.gradle": {
      \       "src/main/kotlin/*.kt": {"alternate": "src/test/kotlin/{}Test.kt"},
      \       "src/test/kotlin/*Test.kt": {"alternate": "src/main/kotlin/{}.kt"},
      \   },
      \ }

" Bugged for now in Macvim
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': '--preview "bat -p --theme=base16 --color=always {}"' }, <bang>0)

" Trigger keys for next position in snippet
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" Make sure we have text-objects for arguments, from vim-swap
omap i, <Plug>(swap-textobject-i)
xmap i, <Plug>(swap-textobject-i)
omap a, <Plug>(swap-textobject-a)
xmap a, <Plug>(swap-textobject-a)

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
colorscheme moonfly
set background=dark
" Use both relative and normal line numbers
set relativenumber
set number
" Use mouse for selecting panes and scrolling
set mouse=nv
set autoindent
" Expand Tabs to spaces
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set scrolloff=6
set sidescrolloff=6
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
  let l:branchname = FugitiveHead()
  " truncate on more than 50 chars
  if strlen(l:branchname) > 50
      return '  '. l:branchname[0 : 50] . '..'
  elseif strlen(l:branchname) > 0
      return '  '. l:branchname
  else
      return''
  endif

endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:spelling = all_errors == 1 ? '' : 's'

    return l:all_errors == 0 ? '' : printf('✗ %d error%s ', all_errors, spelling)
endfunction

function! FileModified() abort
    if &modified
        return "⏺ "
    else
        return ""
    endif
endfunction

function! CombineHighlightGroup(new_highlight, foreground_highlight, background_highlight) abort
    exec 'hi ' . a:new_highlight .
                \' guifg=' . synIDattr(synIDtrans(hlID(a:foreground_highlight)), 'fg', 'gui') .
                \' guibg=' . synIDattr(synIDtrans(hlID(a:background_highlight)), 'bg', 'gui')
endfunction

eval CombineHighlightGroup('CustomStatusLineFile', 'Function', 'StatusLine')
eval CombineHighlightGroup('CustomStatusLineError', 'Error', 'StatusLine')
eval CombineHighlightGroup('CustomStatusLineBranch', 'CursorLineSign', 'StatusLine')
eval CombineHighlightGroup('CustomStatusLineFileType', 'Keyword', 'StatusLine')

set statusline=
set statusline+=\ [%{mode()}] " Mode
set statusline+=\%#CustomStatusLineFile# " Use Error highlight group
set statusline+=\ %{WebDevIconsGetFileTypeSymbol()}\ %f " Filename
set statusline+=\  " Give some spacing to filename if it gets truncated
set statusline+=%{FileModified()} " If file is modified
set statusline+=%* " Return to default color
set statusline+=%< " Force truncation to accommodate narrow windows
set statusline+=%= " Seperation between left and right side
set statusline+=\ %c:%L " Line number and column
set statusline+=%#CustomStatusLineBranch# " Use Error highlight group
set statusline+=%{StatuslineGit()}
set statusline+=\ %* " Return to default color
set statusline+=%#CustomStatusLineError# " Use Error highlight group
set statusline+=%{LinterStatus()}
set statusline+=%* " Return to default color
set statusline+=%#CustomStatusLineFileType# " Use Error highlight group
set statusline+=%y " Filetype
set statusline+=%* " Return to default color
set statusline+=\ 

" common typos of my fingers
iabbrev udpate update
iabbrev  seperate  separate

"""""""""""""""""""""""
" Keymap configurations
"""""""""""""""""""""""
let mapleader=" "
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> ˇ :TmuxNavigateLeft<cr>
nnoremap <silent> ¯ :TmuxNavigateDown<cr>
nnoremap <silent> „ :TmuxNavigateUp<cr>
nnoremap <silent> ‘ :TmuxNavigateRight<cr>

inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "<Plug>delimitMateCR"

" Use Tab key for trigger completion, selection and snippet expand
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" C-j and C-k for autocompletion.
inoremap <expr><C-j>  coc#pum#visible() ? coc#pum#next(1) : pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k>  coc#pum#visible() ? coc#pum#prev(1) : pumvisible() ? "\<C-p>" : "\<C-k>"

" evaluating since coc now has a propriatary popup for completion
hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A
" auto update the CocMenuSel when changing colorscheme
autocmd ColorScheme * hi CocSearch ctermfg=12 guifg=#18A3FF
autocmd ColorScheme * hi CocMenuSel ctermbg=109 guibg=#13354A

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Use C-h and C-l to change buffers
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>
imap <C-l> <Esc>:bn<CR>
imap <C-h> <Esc>:bp<CR>

" Paste without overriding register so that i can continue pasting
" not working for some reason
" vmap p "_dP

" == for format file
nmap == mz=ae`z

" Use Space-Space to Hover with ALE
nnoremap <silent> <Leader><Leader> :ALEHover<CR>

" Bubble selections up and down
vmap <C-j> <Plug>MoveBlockDown
vmap <C-k> <Plug>MoveBlockUp
nmap <C-j> <Plug>MoveLineDown
nmap <C-k> <Plug>MoveLineUp

" Dont use linewise motions
" and make sure that we update the jump-list
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'gj'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'gk'

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

" Change insert surround shortcut, from vim-surround
nmap gl g>
nmap gh g<

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

" Open new line without going into insert mode
nmap <CR> o<Esc>k

" Indent using tab in visual mode
vnoremap <Tab> >gv
vmap <S-Tab> <gv

" Indent using tab in normal mode
nmap <Tab> >>
nmap <S-Tab> <<

" Close quickfix
nmap <Leader>cc :cclose<CR>
" Cycle through results in quickfix
nmap <Leader>N :cnext<CR>
nmap <Leader>P :cprev<CR>
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
" Open alternate file in a vertical or horizontal split
nmap <Leader>va :AV<CR>
nmap <Leader>sa :AS<CR>
" Open alternate file
nmap <Leader>a :A<CR>
" Open tags in current file
nmap <Leader>r :Tags<CR>
" Find project wide
nmap <Leader>f :Ack!<Space>""OD
" Find project wide with what is in the clipboard
nmap <Leader>F :Ack! """<CR>
" Fuzzy Finder, with preview
nmap <Leader>t :Files<CR>
" Run tests for current file
nmap <Leader>rt :TestFile<CR>
" Whose fault is this mess?
nmap <Leader>B :Git blame<CR>
" Run all tests
nmap <Leader>ra :TestSuite<CR>
" Run Test in this line
nmap <Leader>rn :TestNearest<CR>
" Close pane used by Vimux
nmap <Leader>cr :VimuxCloseRunner<CR>
" Run custom command
nmap <Leader>vp :VimuxPromptCommand<CR>
" Vimux Runner
nmap <Leader>vz :VimuxInspectRunner<CR>:VimuxZoomRunner<CR>
" Zoom in on the tmux pane
nmap <Leader>zr :VimuxZoomRunner<CR>
" Run last command with Vimux
nmap <Leader>rr :VimuxRunLastCommand<CR>
" Flash text on yank
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
" Vimux Runner
nmap <Leader>v <Plug>BufTabLine.Go(1)

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
noremap <Up>    <C-W>+
noremap <Down>  <C-W>-
noremap <Left>  3<C-W><
noremap <Right> 3<C-W>>

" Copilot things
nmap <C-t> <Plug>(copilot-suggest)
imap <C-t> <Plug>(copilot-suggest)
imap <C-n> <Plug>(copilot-next)
imap <C-p> <Plug>(copilot-previous)
imap <silent><script><expr> <Space> copilot#Accept("<Space>")
let g:copilot_no_tab_map = v:true
eval CombineHighlightGroup('CopilotSuggestion', 'Function', 'StatusLine')
" (Line-wrapped for legibility) Dont use Copilot on files larger than 100kb
autocmd BufReadPre *
    \ let f=getfsize(expand("<afile>"))
    \ | if f > 100000 || f == -2
    \ | let b:copilot_enabled = v:false
    \ | endif

" Enable command-mouseclick to go to definition (<LeftMouse> is needed to put
" the cursor in the correct spot)
map <M-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>
map <MiddleMouse> <LeftMouse>

" Update GitGutter on save
autocmd BufWritePost * GitGutter
" Remap the jump to next/previous hunks
nmap ]] <Plug>(GitGutterNextHunk)
nmap [[ <Plug>(GitGutterPrevHunk)

" This helps if there was any change to buffer, to be used with autoread
autocmd CursorHold * checktime

" Kotlin settings
autocmd FileType kotlin call SetAlternativeColorscheme()
function! SetAlternativeColorscheme()
    colorscheme spring-night
endfunction

" Ruby and Crystal settings
autocmd FileType ruby,eruby,crystal call SetTwoSpacesSettings()
function! SetTwoSpacesSettings()
    match errormsg '\%>115v.\+'
    set tabstop=2 shiftwidth=2 softtabstop=2
    " Make sure ruby syntax highlighting is not incredible
    " slow by changing the regex engine
    set re=1
endfunction

" Show me the all the quotes in JSON please
autocmd BufEnter *.json set conceallevel=0

" Use CocGoToDefinition and Next/Previous error
autocmd FileType crystal call ChangeJumpToDefinitionCrystal()
function! ChangeJumpToDefinitionCrystal()
    nmap <buffer> <silent> <Leader>j <Plug>(coc-definition)
    nmap <buffer> <silent> <Leader>H <Plug>(coc-type-definition)
    nmap <buffer> <silent> <Leader>J <Plug>(coc-implementation)
    nmap <buffer> <silent> <Leader>l <Plug>(coc-references)
    nmap <buffer> <silent> <Leader>n <Plug>(coc-diagnostic-next)
    nmap <buffer> <silent> <Leader>p <Plug>(coc-diagnostic-prev)
    nmap <buffer> <silent> <Leader><Leader> :call CocActionAsync('doHover')<CR>
endfunction

" Use ALEGoToDefinition and Next/Previous error
autocmd FileType typescript.tsx,typescript,javascript,typescriptreact,kotlin,ruby,rust call ChangeJumpToDefinition()
function! ChangeJumpToDefinition()
    nmap <buffer> <Leader>j :ALEGoToDefinition<CR>
    nmap <buffer> <Leader>J :ALEGoToDefinition -vsplit<CR>
    nmap <buffer> <Leader>n <Plug>(ale_next_wrap)
    nmap <buffer> <Leader>p <Plug>(ale_previous_wrap)
    nmap <buffer> <Leader>l :ALEFindReferences<CR>
endfunction

" Change some ruby definitions because of sorbet
autocmd FileType ruby call ChangeRubyDefinitions()
function! ChangeRubyDefinitions()
    " syntax highlight Sorbet signatures as a comment
    syn match rubySorbetTypeStricness "\%(true\|false\|ignore\|strong\|strict\)"
    hi def link rubySorbetTypeStricness Boolean
    syn match rubyMagicComment "\c\%<10l#\s*\zs\%(typed\):" contained nextgroup=rubySorbetTypeStricness skipwhite
    syn match rubyDocumentation "^\s*sig .*" contains=rubySpaceError,rubyTodo,@Spell fold
    syn region rubyDocumentation start="^\s*sig do$" end="end\%(\s.*\)\=$" contains=rubySpaceError,rubyTodo,@Spell fold

    " Ignore Sorbet results while searching
    let g:ackprg = 'ag --vimgrep --hidden --ignore "tags" --ignore ".git/" --ignore "sorbet/"'
endfunction

" Highlight rbi files as if they were Ruby (they are!)
autocmd BufEnter *.rbi call HighlightRBIFiles()
function! HighlightRBIFiles()
    set syntax=ruby
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

" Save last closed buffer, in case we want to open it again
autocmd BufUnload * call SaveLastClosedBuffer()
function! OpenLastClosedBuffer()
  exe "e " . g:lastWinName
endfunction
function! SaveLastClosedBuffer()
  let filename = expand('<afile>')
  if filename != "!sh" && filename != ""
      let g:lastWinName = filename
  end
endfunction
map <silent> <Leader>T :call OpenLastClosedBuffer()<CR>

" Copy filename to system clipboard
command CopyFilenameToClipboard execute "let @+ = @%" | execute "echo 'Copied " .  getreg('+') . " to the clipboard'"
map <Leader>uc :CopyFilenameToClipboard<CR>
"
map <Leader>up :call PrefixAndRepeat()<CR>:silent! call repeat#set("yiwPa: <Esc>", v:count)<CR>

nnoremap <silent> <Plug>PrefixAndRepeat  :<C-U>call PrefixAndRepeat()<CR>
function! PrefixAndRepeat() abort
    normal yiwPa: 
    silent! call repeat#set("\<Plug>PrefixAndRepeat", 1)
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

" Define 2 spaces for javascript files
autocmd FileType typescript.tsx,typescript,javascript,typescriptreact setlocal shiftwidth=2 tabstop=2

" Make sure we are not off by one when jumping to a result
" because of nmap mapping of <CR>
autocmd BufWinEnter quickfix nmap <buffer> <CR> <CR>

" This must be the last thing in vimrc for some weird reason
" Auto reload vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    if has("gui_running")
        source ~/.gvimrc
    endif
augroup END
