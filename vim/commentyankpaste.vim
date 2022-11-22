function! s:YankCommentPaste(type)
  let saved_unnamed_register = @@

  if a:type ==# 'V'
    normal! '<V'>y
    execute "'<,'>Commentary"
    normal! '>
  elseif a:type ==# 'line'
    normal! '[V']y
    execute "'[,']Commentary"
    normal! ']
  else
    echom "not line"
    return
  endif

  normal! p

  let @@ = saved_unnamed_register
endfunction

" TODO line only, doesnt work with in-function around-function motions
nnoremap <space>y :set operatorfunc=<SID>YankCommentPaste<cr>g@
" alias for <space>y_  Line-motion
nnoremap <space>yy :set operatorfunc=<SID>YankCommentPaste<cr>g@_
vnoremap <space>y :<c-u>call <SID>YankCommentPaste(visualmode())<cr><cr>

