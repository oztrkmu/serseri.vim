" serseri.vim
" A little serseri comfort for writing C. Take it easy, write some C.

set nocompatible

" Space is the leader. Set it before defining mappings.
let mapleader = " "

" Install vim-plug with install.sh. Core settings also work without plugins.
if filereadable(expand('~/.vim/autoload/plug.vim'))
    call plug#begin('~/.vim/plugged')

    " theme / ui
    Plug 'joshdick/onedark.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " navigation
    Plug 'preservim/nerdtree'
    Plug 'preservim/tagbar'

    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    " C / LSP
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " async linting
    Plug 'dense-analysis/ale'

    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " editing
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'jiangmiao/auto-pairs'

    " debugger
    Plug 'puremourning/vimspector'

    " quality of life
    Plug 'editorconfig/editorconfig-vim'
    Plug 'wellle/targets.vim'
    Plug 'machakann/vim-highlightedyank'

    call plug#end()
endif

" core
syntax enable
filetype plugin indent on

set encoding=utf-8
set hidden
set autoread
set number
set relativenumber
set cursorline
set ruler
set signcolumn=yes
set colorcolumn=80
set showcmd
set showmode
set wildmenu
set wildmode=longest:full,full
set laststatus=2
set scrolloff=8
set sidescrolloff=8
set splitbelow
set splitright
set backspace=indent,eol,start

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set shiftround

" search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" performance
set updatetime=200
set timeoutlen=400
set lazyredraw
set ttyfast

" files
set nobackup
set writebackup

" Keep swap files for recovery.
set swapfile

" persistent undo
if has('persistent_undo')
    set undofile
    call mkdir(expand('~/.vim/undo'), 'p')
    set undodir=~/.vim/undo//
endif

" clipboard
set clipboard=unnamedplus

" mouse
set mouse=a

" whitespace
set listchars=tab:>-,trail:.,extends:>,precedes:<

nnoremap <leader>l :set list!<CR>

" theme
if has('termguicolors')
    set termguicolors
endif

set background=dark

silent! colorscheme onedark

let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" save / quit
" Save all changed files and exit. A write error keeps Vim open.
nnoremap <C-z> :wqa<CR>
inoremap <C-z> <Esc>:wqa<CR>
xnoremap <C-z> <Esc>:wqa<CR>
nnoremap <leader>w :write<CR>
nnoremap <leader>W :wall<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>Q :quit!<CR>
nnoremap <leader>x :wq<CR>

" reload vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :edit $MYVIMRC<CR>

" buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>
nnoremap <leader>= <C-w>=

" movement
nnoremap j gj
nnoremap k gk
nnoremap <leader>j 5j
nnoremap <leader>k 5k
nnoremap H ^
nnoremap L $

" visual movement
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" search cleanup
nnoremap <Esc><Esc> :nohlsearch<CR>

" NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>E :NERDTreeFind<CR>
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 0

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fc :Commands<CR>

" ripgrep
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    set grepformat=%f:%l:%c:%m
endif

" Tagbar
nnoremap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0

" CoC
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" completion
if isdirectory(expand('~/.vim/plugged/coc.nvim'))
    inoremap <silent><expr> <Tab>
        \ coc#pum#visible()
        \ ? coc#pum#next(1)
        \ : CheckBackspace()
        \ ? "\<Tab>"
        \ : coc#refresh()

    inoremap <silent><expr> <S-Tab>
        \ coc#pum#visible()
        \ ? coc#pum#prev(1)
        \ : "\<C-h>"

    inoremap <silent><expr> <CR>
        \ coc#pum#visible()
        \ ? coc#pum#confirm()
        \ : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

endif

" LSP navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)

" LSP actions
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca <Plug>(coc-codeaction-cursor)
nmap <leader>ac <Plug>(coc-codeaction-selected)

" diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
nnoremap <leader>dd :CocList diagnostics<CR>

" documentation
function! ShowDocumentation()
    if exists('*CocAction') && CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

nnoremap <silent> K :call ShowDocumentation()<CR>

" clang-format
if executable('clang-format')

    nnoremap <F7>
        \ :%!clang-format<CR>

    vnoremap <F7>
        \ :!clang-format<CR>

endif

" ALE / clang-tidy
let g:ale_linters = {
    \ 'c': ['clangtidy'],
    \ }

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_open_list = 0

" make
nnoremap <F5>
    \ :wall<CR>:silent make!<CR>:redraw!<CR>

nnoremap <F6>
    \ :copen<CR>

" quickfix
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :cclose<CR>

" gcc single file
" Quote absolute paths so spaces and shell characters work too.
function! s:CBuild(sanitize) abort
    if &buftype !=# '' || expand('%:e') !=# 'c'
        echoerr 'Open a named .c file first.'
        return
    endif
    write
    let output = expand('%:p:r') . (a:sanitize ? '-asan' : '')
    let flags = a:sanitize
        \ ? '-O1 -fsanitize=address,undefined -fno-omit-frame-pointer'
        \ : '-O0 -Wshadow -Wconversion'
    execute '!gcc -std=c17 -Wall -Wextra -Wpedantic -g3 ' . flags
        \ . ' ' . shellescape(expand('%:p'), 1) . ' -o ' . shellescape(output, 1)
endfunction

command! CBuild call <SID>CBuild(0)
command! CAsan call <SID>CBuild(1)
command! CRun execute '!' . shellescape(expand('%:p:r'), 1)
command! CValgrind execute '!valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes '
    \ . shellescape(expand('%:p:r'), 1)

nnoremap <leader>cc :CBuild<CR>
nnoremap <leader>cr :CRun<CR>
nnoremap <leader>cs :CAsan<CR>
nnoremap <leader>cv :CValgrind<CR>

" gdb / Vimspector
nnoremap <F9>
    \ :call vimspector#ToggleBreakpoint()<CR>

nnoremap <F10>
    \ :call vimspector#StepOver()<CR>

nnoremap <F11>
    \ :call vimspector#StepInto()<CR>

nnoremap <F12>
    \ :call vimspector#Continue()<CR>

nnoremap <leader>dr
    \ :call vimspector#Reset()<CR>

" git
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap ]h :GitGutterNextHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>
nnoremap <leader>hp :GitGutterPreviewHunk<CR>
nnoremap <leader>hu :GitGutterUndoHunk<CR>

" C configuration
augroup c_config

    autocmd!

    autocmd FileType c setlocal
        \ tabstop=4
        \ shiftwidth=4
        \ softtabstop=4
        \ expandtab

    autocmd FileType c setlocal colorcolumn=80

    autocmd FileType c setlocal commentstring=//\ %s

augroup END

" terminal
nnoremap <leader>tt
    \ :belowright terminal<CR>

tnoremap <Esc>
    \ <C-\><C-n>

" autocmd
augroup serseri

    autocmd!

    " last position
    autocmd BufReadPost *
        \ if line("'\"") > 1 &&
        \ line("'\"") <= line("$") |
        \ execute "normal! g`\"" |
        \ endif

    " auto reload
    autocmd FocusGained,BufEnter *
        \ checktime

augroup END

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4

" status
set showmatch
set matchtime=2

" end
