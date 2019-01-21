" Reload without restarting with :so %

if &compatible
  set nocompatible
endif
filetype off

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'flazz/vim-colorschemes'
Plug 'mileszs/ack.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'

call plug#end()

" Ignore .o files in places like ctrlp
set wildignore+=*.o

" Make vim try to use colors that look good on a dark background
set background=dark

" Color scheme from flazz/vim-colorschemes
" Other schemes I like: jellybeans, maroloccio, moody, moonshine, moss, mustang, nazca,
" spring-night, termschool, codeschool, elda, elrodeo, ghostbuster, hybrid
colorscheme ghostbuster

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
set relativenumber
set number

" Tabs -> spaces, 4 space width, indents, text wrap at 120 characters.
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set tw=120

" FSwitch setup
" Switch from foo.h -> foo_inline.h -> foo.cpp
au! BufEnter *.cpp let b:fswitchdst = 'h'
au! BufEnter *.h let b:fswitchdst = 'h,cpp' | let b:fswitchfnames = '/$/_inline/'
au! BufEnter *_inline.h let b:fswitchdst = 'cpp' | let b:fswitchfnames = '/_inline$//'
map <C-c> :FSHere<CR>
" map <C-c> :A<CR>

" Airline
" let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" cindent setup
" N-s: don't indent inside namespaces
" g0: don't indent C++ scope declarations
" i0: don't indent cases inside switch
set cindent
set cino=N-s,g0,i0

" commentary setup
autocmd FileType cpp set commentstring=//\ %s

" Silver searcher (ag)
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" Re-source init.vim on save.
autocmd! bufwritepost init.vim source %

" Shorten updatetime, this makes the git gutter update faster. This is in milliseconds.
set updatetime=250

