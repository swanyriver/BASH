function GetNoteGFText()
  " TODO does not find proj root
  let l:relativefile=expand('%')
  let l:line = getcurpos()[1]
  return l:relativefile . ":" . l:line
endfunction

function GetNoteFromVis()
  let l:saved_unnamed_register = @@

  normal! gvy
  let l:visselect = @@

  let @@ = l:saved_unnamed_register

  return l:visselect
endfunction

function CopyAndEchoNote(markup)
  let l:f = GetNoteGFText()

  let l:notes = GetNoteFromVis()

  let l:buff = l:f . "\n" . a:markup . l:notes . a:markup
  call SendToTmuxAndClipboard(l:buff)
endfunction

vnoremap <leader>n :<c-u>call CopyAndEchoNote("")<CR>
vnoremap <leader>md :<c-u>call CopyAndEchoNote("```\n")<CR>
"TODO operatorfunc could be used to do with motions/ranges vim/commentyankpaste.vim:?l=26

