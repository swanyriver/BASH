"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""vim keymaps"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap window navigation sequences (no collisions)
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" make <C-Left> and <C-Right> work on screen term and tmux, note not needed for nvim
if &term =~ "screen" && !has('nvim')
  map <esc>[1;5D <C-Left>
  map <esc>[1;5C <C-Right>
endif

nnoremap <silent> <C-Left> :tabprev<CR>
nnoremap <silent> <C-Right> :tabnext<CR>

" clear search highlighting
nnoremap <silent> <Leader>/ :noh<CR>

" Load a substitution where the pattern is the word under the cursor,
" ready for you to type the replacement.
nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/

" map enter key to <C-y> for popupmenus like autocomplete
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" navigate paragraphs without landing in the middle, good for limelight
nnoremap OB })zt
nnoremap OA {(zt{)

" make Y behave like D, otherwise it is just a synonym of yy
nnoremap Y y$

" jump forward to next qoute and change inside
onoremap in" :<c-u>normal! f"vi"<cr>
onoremap il" :<c-u>normal! F"vi"<cr>

" jump forward to next [] and change inside
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>

" toggle spell check
nnoremap <silent> <Leader>k :set spell!<CR>

