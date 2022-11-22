autocmd FileType c,cpp,java setlocal commentstring=//\ %s

" Searches are case insensitive when they are only lower case
set ignorecase smartcase

" Incremental search, hightlights all matches and auto jump
set incsearch hlsearch

" ideavim specific
set showmode

" emulated plugins
" see: https://github.com/JetBrains/ideavim/wiki/Emulated-plugins
set commentary
set highlightedyank
set ReplaceWithRegister

nmap <Leader>s  <Plug>ReplaceWithRegisterOperator
nmap <Leader>ss <Plug>ReplaceWithRegisterLine
xmap <Leader>s  <Plug>ReplaceWithRegisterVisual

