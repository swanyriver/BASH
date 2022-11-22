" turns 'FooBar' into 'FooBar foo_bar' or 'FooBar fooBar'
function s:NameVar()
  let l:saved_unnamed_register = @@
  " find previous alpha
  call search("[a-z,A-Z]","b")
  noh
  norm yiw
  norm E

  let l:varname = @@

  " TODO detect if there is already a space
  execute "normal! a " . l:varname . "\<esc>"
  if &filetype == "cpp" || &filetype == "c"
    call ToggleCwordCase()
  else
    norm BgulE
  end

  let @@ = l:saved_unnamed_register
endfunction

nnoremap <silent><space>v :<c-u> call <SID>NameVar() <cr>
