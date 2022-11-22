" Provide functions for going between snake case and camel case
" along with a function and keymap for doing so to the word under the cursor

function ToSnakeCase(cammel_word)
  let l:snake_word = substitute(a:cammel_word, '\v\C([A-Z])', '_\l\1', 'g')
  let l:snake_word = substitute(l:snake_word, '^_', '', '')
  return l:snake_word
endfunction

function ToCamelCase(snake_word)
  let l:camel_word = substitute(a:snake_word, '_\([a-z0-9]\)', '\u\1', 'g'  )
  let l:camel_word = substitute(l:camel_word, '_$', '', '')
  return l:camel_word
endfunction


function IsCamelCase(word)
  return a:word =~# '^[A-Z]\?[a-z0-9]\+\([A-Z][a-z0-9]\+\)*$'
endfunction


function IsSnakeCase(word)
  return a:word =~# '\v^[a-z]+(_[a-z]+)+_?$'
endfunction

function ToggleCase(word)
  if IsSnakeCase(a:word)
    return ToCamelCase(a:word)
  elseif IsCamelCase(a:word)
    return ToSnakeCase(a:word)
  else
    return a:word
  endif
endfunction

function! ToggleCwordCase()
  let saved_unnamed_register = @@

  let toggled_word = ToggleCase(expand('<cword>'))
  execute "normal! ciw" . toggled_word . "\<esc>"

  let @@ = saved_unnamed_register
endfunction

function! ToggleVisualCase(type)
  if a:type !=# 'v'
    return
  endif

  let saved_unnamed_register = @@

  normal! `<v`>d
  let toggled_word = ToggleCase(@@)
  execute "normal! i" . toggled_word . "\<esc>"

  let @@ = saved_unnamed_register
endfunction

nnoremap <silent><leader>t :<c-u> call ToggleCwordCase() <cr>
vnoremap <silent><leader>t :<c-u> call ToggleVisualCase(visualmode())<cr>
