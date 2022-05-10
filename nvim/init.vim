call plug#begin()
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'sheerun/vim-polyglot'
  Plug 'dense-analysis/ale'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Set theme color
"colorscheme codedark
set termguicolors
set t_Co=256
set background=dark
"set completeopt=menu,menuone,popup               "enable popup window
"set completepopup=highlight:InfoPopup,border:off "configure the highlight group
colorscheme kuroi

" Airline configs
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

highlight Normal ctermbg=Black
highlight NonText ctermbg=Black

syntax on

" Basic configs
set nu!
set mouse=a
set title
set cursorline
set encoding=utf-8
set colorcolumn=80
set autoread

" Config split
set splitbelow
set splitright

" File
filetype on
filetype plugin on
filetype indent on

" Config Tabs
set softtabstop=2
set tabstop=2
set expandtab
set shiftwidth=2
set smarttab
set smartindent
set autoindent
set hidden

" Config search
set hlsearch
set incsearch
set smartcase


set scrolloff=8

" Basic maps
map <C-s> :write<CR>

" COC configs
let g:coc_git_status = 1

" Ale configs
let b:ale_linters = [ 'eslint' ]

