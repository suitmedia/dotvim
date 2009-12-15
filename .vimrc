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
set smartcase

" cmd history
set history=1000

" indent
set softtabstop=2
"set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set smartindent
set expandtab
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

set showmatch
set matchtime=1
set backspace=indent,eol,start
set cursorline
set hidden
set ofu=syntaxcomplete#Complete

" bottom
set showcmd
set showmode

" I love Monaco
set guifont=Monaco\ 11

map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
map <S-Tab> :NERDTreeToggle<CR>
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map ;; :! 
map ,y "+y
map ,p "+gp
map ,tt :%s/\t/  /g<CR>
map <A-"> ysiw"
map <A-(> ysiw)
map <A-)> ysiw)
map <C-Backspace> db
map ,f :FuzzyFinderTextMate<CR>
map ,b :FuzzyFinderBuffer<CR>
map ,r :ruby finder.rescan!<CR>

" fuzzyfinder
let g:fuzzy_matching_limit='50'
let g:fuzzy_ignore='*.log, data/*, data_test/*, data_test/**, tmp/*, coverage/*'
if filereadable(expand('./vendor'))
  let g:fuzzy_roots=['app', 'lib', 'config', 'spec', 'test', 'features', 'public']
endif

if version >= 500
  if !exists("syntax_on")
    syntax on
  endif
endif

if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
    colorscheme slate 
endif

