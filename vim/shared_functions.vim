let g:source_trivial_bash =  "source ".$HOME."/BASH/_my_hg; "
let g:source_trivial_bash .= "source ".$HOME."/BASH/_bash_functions; "
let g:source_trivial_bash .= "source ".$HOME."/BASH/_autogit; "

function EchoWarn(msg) abort
  echohl WarningMsg | echom "" . a:msg | echohl None
endfunction

function IsDirty() abort
  let l:cmd = g:source_trivial_bash . " names | rg " . @% . " --no-config -"
  let l:result = trim(system(cmd))
  if empty(l:result)
    return 0
  endif
  return 1
endfunction

let g:file_at_head_cmd = "file_at_head"

" NOTE: returns empty if unable to match line
function FindLine() abort
  if !IsDirty()
    return getcurpos()[1]
  endif

  let l:line=getline('.')

  let l:cmd = join([g:source_trivial_bash, g:file_at_head_cmd, @%, '| rg --no-config -n -F', shellescape(l:line)])
  " cut just the line-number
  let l:cmd = join([l:cmd, '| cut -f 1 -d ":"'])
  let l:lineNuberSearch=trim(system(l:cmd))
  if l:lineNuberSearch =~ "\n" || l:lineNuberSearch =~ "\r"
    return ""
  endif
  " encompases empty or one match case
  return l:lineNuberSearch
endfunction

