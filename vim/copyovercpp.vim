function CopyOverCpp()
  let l:saved_unnamed_register = @@
  let copy_from_save_cursor = getcurpos()
  normal ^Y
  wincmd h
  let copy_to_save_cursor = getcurpos()

  if @@ =~ "\^using "
    " echo "copy using"
    normal G
    let l:foundline = search("^using ", "b")
    call append(l:foundline, @@)
    write
  elseif @@ =~ "\^#include "
    " echo "copy include"
    normal G
    let l:foundline = search("^#include ", "b")
    call append(l:foundline, @@)
    write
  else
    echom "not a using or include"
  endif

  call setpos('.', copy_to_save_cursor)
  normal j
  wincmd l
  call setpos('.', copy_from_save_cursor)
  let @@ = l:saved_unnamed_register
endfunction

nnoremap <space>c :<c-u>call CopyOverCpp()<cr>
