set nocompatible
filetype off
set t_Co=256

" Vundle setup
let g:ctrlp_extensions = ['funky','switcher']
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Bundle 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'ivan-cukic/vim-ctrlp-switcher'
Bundle 'derekwyatt/vim-fswitch'
call vundle#end()
filetype plugin indent on

" Syntax highlighting
syntax enable
set background=dark
colorscheme solarized

" Tabs -> spaces, 4 space width, indents
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" airline modes
let g:airline#extensions#tabline#enabled = 1

" Incremental and highlighted searching
set incsearch
set hlsearch

" Re-source vimrc on save.
autocmd! bufwritepost .vimrc source %

" FSwitch setup
" Switch from foo.h -> foo_inline.h -> foo.cpp
au! BufEnter *.cpp let b:fswitchdst = 'h'
au! BufEnter *.h let b:fswitchdst = 'h,cpp' | let b:fswitchfnames = '/$/_inline/'
au! BufEnter *_inline.h let b:fswitchdst = 'cpp' | let b:fswitchfnames = '/_inline$//'

" NERDTree setup
" Close vim if the only window left open is NERDTree.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>

" cindent setup
" N-s: don't indent inside namespaces
" g0: don't indent C++ scope declarations
" :0: don't ident cases inside switch
set cindent
set cino=N-s,g0,:0

" airline setup
set laststatus=2
