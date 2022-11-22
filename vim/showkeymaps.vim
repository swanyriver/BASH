function! s:ShowKeymaps()
  tab new
  setlocal buftype=nofile
  setlocal noswapfile

  redir @a
  silent verbose map
  silent verbose map!
  redir END
  normal! "ap<esc>
  %s/ line /:/g

endfunction

nnoremap <silent><leader>m :<c-u>call <SID>ShowKeymaps()<cr>
