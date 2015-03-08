set nocompatible
filetype off
set t_Co=256

" Vundle setup
let g:ctrlp_extensions = ['funky','switcher']
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Bundle 'altercation/vim-colors-solarized'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Bundle 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'ivan-cukic/vim-ctrlp-switcher'
Bundle 'derekwyatt/vim-fswitch'
Plugin 'flazz/vim-colorschemes'
call vundle#end()
filetype plugin indent on

" Syntax highlighting
syntax enable
set background=dark
colorscheme solarized
" others I like: darkburn, southwest-fog, twilight

" Tabs -> spaces, 4 space width, indents, text wrap at 120 characters.
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set tw=120

" In gvim, remove all of the GUI widgets
set guioptions-=m " remove menu bar
set guioptions-=T " remove toolbar
set guioptions-=r " remove right-hand scroll bar
set guioptions-=L " remove left-hand scroll bar

" Relative line numbering
set relativenumber

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
map <C-c> :FSHere<CR>

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

" commentary setup
autocmd FileType cpp set commentstring=//\ %s

" airline setup
set laststatus=2

