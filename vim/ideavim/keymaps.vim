"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""vim keymaps"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NOTE: this works in ideavim,  and :split works
" NOTE: tabs are within splits instead of vice versa
" Remap window moving sequences (no collisions)
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

sethandler <C-Left> a:ide
sethandler <C-Right> a:ide
nnoremap <silent> <C-Left> :tabprev<CR>
nnoremap <silent> <C-Right> :tabnext<CR>

" clear search highlighting
nnoremap <silent> <Leader>/ :noh<CR>

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
