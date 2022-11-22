function! SendToTmuxAndClipboard(text)
  " Send to tmux
  let _ = system("tmux loadb <( echo -n " . shellescape(a:text) . ")")
  " Send to clipboard using xsel and tmux DISPLAY settings
  let _ = system("tmux run 'tmux showb | xsel -i --clipboard'")
  let l:line_count = trim(system("tmux showb | wc -l"))
  unsilent echo "attempted to send " . l:line_count . " lines to clipboard from tmux buffer"
endfunction

function! s:SendToTmuxOperator(type)
  let saved_unnamed_register = @@

  " TODO create operatorfunc type-yank function that can be shared
  if a:type ==# 'line'
    let l:yank_command = "'[V']"
  elseif a:type ==# 'char'
    let l:yank_command = '`[v`]'
  elseif a:type ==# 'v'
    let l:yank_command = '`<v`>'
  elseif a:type ==# 'V'
    let l:yank_command = "'<V'>"
  elseif a:type ==? "\<C-V>"
    let l:yank_command = "`<\<C-V>`>"
  else
    return
  endif
  execute 'silent normal! ' . l:yank_command . 'y'

  call SendToTmuxAndClipboard(@@)

  let @@ = saved_unnamed_register
endfunction

" TODO consider \y to stay with space|\ scheme
nnoremap <silent> <space>t  :set operatorfunc=<SID>SendToTmuxOperator<cr>g@
nnoremap <silent> <space>tt :set operatorfunc=<SID>SendToTmuxOperator<cr>g@_
vnoremap          <space>t  :<c-u> call <SID>SendToTmuxOperator(visualmode())<cr>
