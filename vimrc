" Xinuc's .vimrc
" by Nugroho Herucahyono <xinuc@xinuc.org>

" Duh. I'm using VIM
set nocompatible

" backspace
set backspace=indent,eol,start

" wrapping
set wrap
set linebreak

" trailling
set list
set listchars=tab:>-,trail:.

" search
set incsearch
set hlsearch
set ignorecase

" cmd history
set history=1000

" indent
set softtabstop=2
set tabstop=2
"set smarttab
set shiftwidth=2
"set autoindent
"set smartindent
"set expandtab
set cindent
set cpoptions-=J

" window
set winminheight=0

" other display
set ch=2
set mousehide
set et!

"set number
set scrolloff=2
set ruler

"guioptions
set go=aiA

set showmatch
set matchtime=1
set backspace=indent,eol,start
set cursorline
set hidden
set ofu=syntaxcomplete#Complete

" bottom
set showcmd
set showmode

map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
map <S-Tab> :NERDTreeToggle<CR>
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map ,y "+y
map ,p "+gp
map <C-Backspace> db

map ,l :set list!<CR>

nmap <silent> ,t :CommandT<CR>

syntax on
filetype plugin indent on

set listchars=tab:▸\ ,eol:¬
