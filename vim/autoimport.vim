" example
" rg -o --no-filename --no-config '^import.*Class;' $dir | sort | uniq
function GetImportFindCommand(class)
  let l:cmd="rg -o --no-filename --no-config "
  if &filetype == "java"
    let l:file = expand("%:p")
    if l:file =~ "/javatests/"
      let l:cmd .= "--iglob='javatests/**/*.java' "
    else
      let l:cmd .= "--iglob='*.java' "
    endif
    return l:cmd . " '^import.*\\." . a:class . ";' " . g:java_dirs
  endif
  if &filetype == "cpp"
    " just need foo.cpp or foo_test.cpp
    let l:file = expand('%:t:r')
    if l:file =~ "_test$"
      let l:cmd .= "--iglob='*_test.cc' "
    else
      let l:cmd .= "--iglob='*.cc' "
    endif
    "TODO better would be to search .h files for class def
    return l:cmd . " '^#include.*" . ToggleCase(a:class) . "\\.h\"' " . g:cpp_dirs
  endif

  return ""
endfunction

function FindImport(class)
  let l:command = GetImportFindCommand(a:class)
  if empty(l:command)
    call EchoWarn("E: auto import not supported for this file")
    return
  endif
  let l:command .= " | sort | uniq"

  let l:result = trim(system(l:command))
  if empty(l:result)
    call EchoWarn("E: no import found")
  endif
  return l:result
endfunction

function FindExistingImport(class)
  let save_cursor = getcurpos()
  let import_line = 0
  if &filetype == "java"
    let import_line =search("^import.*\\." . a:class . ";")
  endif
  if &filetype == "cpp"
    let import_line =search("^#include.*" . ToggleCase(a:class) . "\\.h\"")
  endif
  call setpos('.', save_cursor)
  if import_line
    return getline(import_line)
  endif
endfunction

function AppendAfterImports(import_line)
  let save_cursor = getcurpos()

  let l:foundline = 0
  if &filetype == "java"
    let l:foundline = search("^import", "b")
  endif
  if &filetype == "cpp"
    let l:foundline = search("^#include", "b")
  endif
  call append(l:foundline, a:import_line)
  echom "ADDED: " . a:import_line

  let prevlnum = save_cursor[1]
  let save_cursor[1] = prevlnum + 1
  call setpos('.', save_cursor)
endfunction

function AddImport(class)

  let existing_import=FindExistingImport(a:class)
  if !empty(l:existing_import)
    echom "Already-Imported-As:  " . l:existing_import
    return
  endif

  let l:result=FindImport(a:class)
  if empty(l:result)
    return
  endif

  call AppendAfterImports(l:result)

endfunction

nnoremap <space>i :<c-u>call AddImport(expand('<cword>'))<cr>

