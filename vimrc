set nocompatible
filetype off
set t_Co=256

" Vundle setup
let g:ctrlp_extensions = ['funky','switcher']
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'ivan-cukic/vim-ctrlp-switcher'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'sickill/vim-monokai'
Plugin 'SirVer/ultisnips'
Plugin 'airblade/vim-gitgutter'
Plugin 'chrisbra/csv.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'mileszs/ack.vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sickill/vim-pasta'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'vasconcelloslf/vim-interestingwords'
Plugin 'fatih/vim-go'

call vundle#end()
filetype plugin indent on

set runtimepath+=~/dotfiles

" Syntax highlighting
syntax enable
set background=dark
colorscheme hybrid
" others good w/256 color terminal: gruvbox, hybrid, monokai
" others I like: twilight, darkburn, southwest-fog, twilight, chance-of-storm

" Tabs -> spaces, 4 space width, indents, text wrap at 120 characters.
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set tw=120

" Allow deletion of previously entered stuff in insert mode.
set backspace=indent,eol,start

" gvim gui setup
set guioptions-=m " remove menu bar
set guioptions-=T " remove toolbar
set guioptions-=r " remove right-hand scroll bar
set guioptions-=L " remove left-hand scroll bar
set guicursor=a:blinkon700-blinkoff500

" Relative line numbering
set relativenumber

" airline modes
let g:airline#extensions#tabline#enabled = 1

" Incremental and highlighted searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" Go settings
" Hard tabs, but display them as 4 spaces wide rather than 8
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

" Remap search keys so that search results appear in the middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <F3> :set hlsearch!<CR>

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
set cino=N-s,g0,i0

" commentary setup
autocmd FileType cpp set commentstring=//\ %s

" airline setup
set laststatus=2

" Ignore .o files in places like ctrlp.
set wildignore+=*.o

