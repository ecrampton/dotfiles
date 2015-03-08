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
Bundle 'justmao945/vim-clang'
Bundle 'ivan-cukic/vim-ctrlp-switcher'
call vundle#end()
filetype plugin indent on

" Syntax highlighting
syntax enable
set background=dark
colorscheme solarized

" Tabs -> spaces, 4 space width, indents
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
"set cindent

" Keys
map <C-n> :NERDTreeToggle<CR>

" airline modes
let g:airline#extensions#tabline#enabled = 1

" Incremental and highlighted searching
set incsearch
set hlsearch

" Re-source vimrc on save.
autocmd! bufwritepost .vimrc source %

" FSwitch setup
au! BufEnter *.cpp let b:fswitchdst = 'h,_inline.h'
au! BufEnter *.h let b:fswitchdst = '_inline.h,cpp'

