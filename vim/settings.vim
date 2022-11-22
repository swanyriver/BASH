"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""vim settings""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup myFileTypeAutos
  autocmd!

" Treat my 'dotfiles' as sh
autocmd BufNewFile,BufRead,Bufenter ~/BASH/_* setfiletype sh
autocmd BufNewFile,BufRead,Bufenter ~/BASH/*/_* setfiletype sh

autocmd BufNewFile,BufRead,Bufenter ~/BASH/*.rc setfiletype cfg
autocmd BufNewFile,BufRead,Bufenter ~/BASH/*/*.rc setfiletype cfg

" treat markdeep html as markdown
autocmd BufNewFile,BufRead,Bufenter *.md.html setfiletype markdown

" Treat my nvim files as vim
autocmd BufNewFile,BufRead,Bufenter *.nvim setfiletype vim

" special filetype for my TODOs
autocmd BufNewFile,BufRead,Bufenter *.todo setfiletype gitconfig
autocmd BufNewFile,BufRead,Bufenter *.todo setlocal commentstring=#%s
autocmd BufNewFile,BufRead,Bufenter *.todo setl noai nocin nosi inde=

" Change commentaries comment string /**/ can leave uncommented innerline comments
autocmd FileType c,cpp,java setlocal commentstring=//\ %s

augroup END

" Files have numbers on the left
set number

" Searches are case insensitive when they are only lower case
set ignorecase smartcase

" Always uses spaces to indent
set expandtab

" Show (partial) command in status line.
set showcmd

" Show matching brackets.
set showmatch

" Incremental search, hightlights all matches and auto jump
set incsearch hlsearch

" Make external commands work through a pipe instead of a pseudo-tty
if !has('nvim')
  set noguipty
endif

" dict complete but only if spellcheck is on
set complete+=kspell
" Set spellcheck on for git commit message
autocmd FileType gitcommit,hgcommit setlocal spell

" Prefer vertical orientation when using :diffsplit
set diffopt+=vertical

" set frequency of swap-file write and CursorHold events.
" affects autowrite,autoread (inderectly) and some git plugins.
set updatetime=150

" More history and more marks and registers
set history=200
set viminfo='50,\"200
set undofile

" keep cursor at least 3 from bottom
set scrolloff=3

" Every window has a status bar
set laststatus=2

" No line wrapping
set wrap!

" color scheme
" from my runtime
color flattown
color color_overrides

" Splits open right
set splitright

set shiftwidth=2
set shiftround
set tabstop=2
set textwidth=80

" ex mode tab completion shows avail options
set wildmenu

set grepprg=rg\ --no-config\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

set dictionary=/usr/share/dict/words

" number of written chars before an update is made to swp file
set updatecount=70

" Always reload buffer when external changes detected
"   autoread enables auto loading of changes when timestamp changed.
"   cursorhold action will checktime of file when cursor inavtive for
"   {updatetime}.
set autoread

set autoindent nocindent nosmartindent
set backspace=indent,eol,start
set cpo-=C
set cpo&vim
set formatoptions+=r
set hidden
set history=50
set nocompatible
set nomodeline
set ruler
set smarttab

" filetype plugs often overwrite this
" disable textrwapping would rather clean it up with tool
augroup setFormatOptionsGroup
  autocmd!
  autocmd BufNewFile,BufRead,Bufenter * setlocal formatoptions=jrql
augroup END

" signcolumn alwasy visible, instead of popping in when plugins load
set signcolumn=yes

" use`: set list` to show whitespace,  `:set nolist` to disable
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\

filetype plugin indent on
syntax on
