" For c/c++ switching from .h/.cc files easily
function s:GetHeaderOrImpl(file)
  let l:file_split = split(a:file, '\.')
  if l:file_split[-1] == "h"
    let l:file_split[-1] = "cc"
  elseif l:file_split[-1] == "cc"
    let l:file_split[-1] = "h"
  endif
  return join(l:file_split, ".")
endfunction

function SwitchToHeaderOrImpl()
  let l:newFileName = <SID>GetHeaderOrImpl(@%)
  execute "edit " . l:newFileName
endfunction

function SplitToHeaderOrImpl()
  let l:newFileName = <SID>GetHeaderOrImpl(@%)
  execute "vsplit " . l:newFileName
endfunction

nnoremap <leader>h :<c-u>call SwitchToHeaderOrImpl()<cr><cr>
nnoremap <leader>H :<c-u>call SplitToHeaderOrImpl()<cr><cr>

" TODO: easier way to copy function defs from h/cc or apply edit to both
