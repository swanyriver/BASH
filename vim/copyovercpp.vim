function CopyOverCpp()
  let l:saved_unnamed_register = @@
  normal ^Y
  wincmd w
  let save_cursor = getcurpos()

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

  call setpos('.', save_cursor)
  normal j
  wincmd w
  let @@ = l:saved_unnamed_register
endfunction

nnoremap <space>c :<c-u>call CopyOverCpp()<cr>
