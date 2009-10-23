" Xinuc's .vimrc
" by Nugroho Herucahyono <xinuc@xinuc.org>

" Duh. I'm using VIM
set nocompatible

" backspace
set backspace=indent,eol,start

" wrapping
set wrap
set linebreak

" search
set incsearch
set hlsearch
set ignorecase

" cmd history
set history=1000

" indent
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
set expandtab

" other display
set ch=2
set mousehide
set et!

"set number
set scrolloff=2
set ruler

" bottom
set showcmd
set showmode

" I love Monaco
set guifont=Monaco\ 11
"set guifont=Monaco\ 9


map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
map <S-Tab> :NERDTreeToggle<CR>
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map ;; :! 
map ,y "+y
map ,p "+gP
map ,tt :%s/\t/  /g<CR>
map ,do %ma%xido<ESC>`axiend<ESC>
map <A-"> ysiw"
map <C-Backspace> db

if version >= 500
  if !exists("syntax_on")
    syntax on
  endif
endif

if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
    colorscheme slate 
endif

