set nocompatible  " be iMproved
filetype off      " required

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle required!
Bundle 'gmarik/vundle'
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" above powerline requires python enabled vim
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'klen/python-mode'
Bundle 'vim-scripts/pep8'
Bundle 'vim-scripts/mru.vim'
" Most Recently Used files
Bundle 'majutsushi/tagbar'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'wincent/Command-T'
" Bundle 'ivanov/vim-ipython'
Bundle 'msanders/snipmate.vim'
Bundle 'mileszs/ack.vim'
Bundle 'FuzzyFinder'
Bundle 'L9'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'Zenburn'





" let g:EasyMotion_leader_key = 'S'

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 80
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd Filetype python match Excess /\%80v.*/
    autocmd Filetype python set nowrap
augroup END

map <F2> :NERDTreeToggle<CR>

" Indent
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
filetype plugin indent on
filetype indent on

syntax on

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2  " ensures status bar shows
set relativenumber
" set undofile        don't want persistant undos
set wrap
set textwidth=79
set formatoptions=qrn1


" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
set nohidden   " rm buffer on tab close

" folding w/ py bias
set foldmethod=indent
set foldlevel=99
set foldnestmax=1

nnoremap ; :
au FocusLost * :wa

" Macros are like anonymous functions

" Leader: usr-specified customisations, kind of namespace
let mapleader = ","  " dflt \
" strip all trailing whitespace in curr file:
nnoremap ,W : %s/\s\+$//<crw>:let @/=''<CR>
nnoremap ,a : Ack

inoremap jj <ESC>

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

" Python
set colorcolumn=85
let g:pymode_lint = 1
let g:pymode_syntax = 1
let g:pymode_rope = 0    " disable for YCM jedi


map <Leader>w :call Browser ()<CR>  " open url on this line