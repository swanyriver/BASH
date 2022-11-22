augroup opencleanswaps
  autocmd!
  autocmd SwapExists *  call <SID>EditIfFileHasNoModifications(v:swapname)
augroup END

function! s:EditIfFileHasNoModifications(swapname)
  let info=swapinfo(a:swapname)
  if (!info.dirty)
    echom "SWP-CHECKER: opened file for edit because swp file is present but no modifications"
    let v:swapchoice = 'e'
  else
    echom "WHATCH OUT:  ITS DIRTY,  you have unsaved changes somewhere else"
  endif
endfunction

