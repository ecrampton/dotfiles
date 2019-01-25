" Reload without restarting with :so %

if &compatible
  set nocompatible
endif
filetype off

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-fswitch'
Plug 'flazz/vim-colorschemes'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'

" Only include this if the OS doesn't have fzf installed by the package manager.
if !executable('/usr/bin/fzf')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif

call plug#end()

" Ignore .o files in places like ctrlp
set wildignore+=*.o

" Make vim try to use colors that look good on a dark background
set background=dark

" Color scheme from flazz/vim-colorschemes
" Other schemes I like: jellybeans, maroloccio, moody, moonshine, moss, mustang, 
" spring-night, termschool, elda, elrodeo, ghostbuster, hybrid
colorscheme ghostbuster

" Better color for paren matching w/ghostbuster
hi MatchParen cterm=bold ctermfg=23

" Searching
set ignorecase " ignore case when searching...
set smartcase  " ...unless differing cases specified

" Remap search keys so that search results appear in the middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <F3> :set hlsearch!<CR>

" Line numbering
set number

" Tabs -> spaces, 4 space width, indents, text wrap at 120 characters, but turn off wrapping by default
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set tw=120
set formatoptions-=t

" Switch from foo.h -> foo_inline.h -> foo.cpp
au! BufEnter *.cpp let b:fswitchdst = 'h'
au! BufEnter *.h let b:fswitchdst = 'h,cpp' | let b:fswitchfnames = '/$/_inline/'
au! BufEnter *_inline.h let b:fswitchdst = 'cpp' | let b:fswitchfnames = '/_inline$//'
map <C-c> :FSHere<CR>

" Projectionist alternate file
" Unfortunately, projectionist doesn't remember where you were in the file when switching back. Until
" that's fixed, I can't use it.
" map <C-c> :A<CR>

" Airline
" let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" commentary setup
autocmd FileType cpp set commentstring=//\ %s

" Silver searcher (ag)
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" FZF
map <C-p> :FZF<CR>
map <M-p> :Buffers<CR>
map <C-M-p> :History<CR>

" Shorten updatetime, this makes the git gutter update faster. This is in milliseconds.
set updatetime=250

" Make navigator use Meta instead of Control. Control-h can have issues, depending on
" the terminal
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-\> :TmuxNavigatePrevious<cr>

" cindent setup
" N-s: don't indent inside namespaces
" g0: don't indent C++ scope declarations
" i0: don't indent cases inside switch
set cindent
set cino=N-s,g0,i0

" Clang formatting
let g:clang_format#style_options = {
    \ "BasedOnStyle": "LLVM",
    \ "IndentWidth": 4,
    \ "AlignAfterOpenBracket": "DontAlign",
    \ "AllowShortBlocksOnASingleLine": "true",
    \ "AllowShortCaseLabelsOnASingleLine": "true",
    \ "AllowShortFunctionsOnASingleLine": "Inline",
    \ "AllowShortIfStatementsOnASingleLine": "false",
    \ "AllowShortLoopsOnASingleLine": "false",
    \ "BreakBeforeBinaryOperators": "NonAssignment",
    \ "BreakBeforeBraces": "Custom",
    \ "BraceWrapping": {
    \ "    AfterFunction": "true",
    \ "    BeforeElse": "true",
    \ },
    \ "ColumnLimit": 120,
    \ "FixNamespaceComments": "true",
    \ "IndentCaseLabels": "true",
    \ "IndentPPDirectives": "AfterHash",
    \ "PointerAlignment": "Middle",
    \ "UseTab": "Never",
    \ "AccessModifierOffset": -4,
    \ "AlwaysBreakTemplateDeclarations": "Yes",
    \ }
