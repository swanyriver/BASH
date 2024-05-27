" Functions just to be called from : prompt

" :h user-commands
" command! -nargs=1 Myfunc call MyFunction(<args>)

function Scratch()
  vnew
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction
command! Scratch call Scratch()

function HScratch()
  new
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
endfunction
command! HScratchH call HScratch()
