" example github url with file:line:commit
" https://github.com/user/BASH/blob/3d71d666f0a46a3f92456fca063a7c212bc4ca87/vim/vimrc.vim#L17
function! GetRemoteGFText() abort
  let l:fullfile=expand('%:p')
  if l:fullfile =~ "/dir/one"
    " project specic logic
  elseif l:fullfile =~ "/dir/two"
    let l:prerfix = 'http://<domain>/<project>'
    let l:file = matchlist(l:fullfile, '\v(.*)(project-top-level-dir\/)(.*)')[3]
    let l:line = FindLine()
    if empty(l:line)
      call EchoWarn( "BRANDON couldn't find un-ambiguous line, line# will be approximate")
      let l:line = getcurpos()[1]
    endif
    let l:linearg = '<line-prefix>' . l:line
    let l:cmd = "source ".$HOME."/BASH/<get-linkable-head-rev-script-file>; ; get_linkable_head_rev"
    let l:revNumber = trim(system(cmd))
    " assemble URL from file,line,revision|commit
    return l:prerfix . "/" . l:revNumber . "/" . l:file . l:linearg
  endif
  return "Not in project dir"
endfunction

function CopyAndEchoRemoteLink() abort
  let l:link = GetRemoteGFText()
  call SendToTmuxAndClipboard(l:link)
  echom l:link
endfunction

" TODO add operatorfunc so motions work
nnoremap <leader>rl :call CopyAndEchoRemoteLink()<CR>
vnoremap <leader>rl :<c-u>call CopyAndEchoNote("```\n", GetRemoteGFText())<CR>

" TODO assumes at root because: FindLine() assumes at root
function GetCommitLink() abort
  let l:fullfile=expand('%:p')
  if l:fullfile !~ "/<project-root>"
    call EchoWarn("not in project")
    return
  endif

  let l:file = matchlist(l:fullfile, '\v(.*)(project-top-level-dir\/)(.*)')[3]

  let l:line = FindLine()
  if empty(l:line)
    call EchoWarn("BRANDON couldn't find un-ambiguous line for revision")
    return
  endif

  let l:getrevcmd = "<some-blame-command>" . l:file . l:line
  let l:revnum = trim(system(l:getrevcmd))

  " TODO extract to stratch buf function or autocmd https://irian.to/blogs/scratch-notes-in-vim/
  " TODO not showing SCRATCH in airline, but it is working
  tab split
  vnew
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal wrap
  setlocal linebreak

  execute "silent r! <some-command-to-get-change-description> " . l:revnum . "\""

  echom "http://<change-view-url>" . l:revnum
endfunction

nnoremap <leader>cl :call GetCommitLink()<CR>


function GetFileAndLineFromRemoteLink(line)
  let l:matches = matchlist(a:line, '\v(.*)http://<some-regex-with-groups-for-line-and-file>')
  if !len(l:matches)
    " alternate regex for alternate url-formats
    let l:matches = matchlist(a:line, '\v(.*)http://<some-regex-with-groups-for-line-and-file>')
  endif
  if !len(l:matches)
    " try matching without line number
    let l:matches = matchlist(a:line, '\v(.*)http://<some-regex-with-groups-for-just-file>')
  endif

  if !len(l:matches)
    return {}
  endif

  let l:result = {}
  let l:result.file=matches[3]
  if len(l:matches[5])
    let l:result.line=matches[5]
  endif
  return result
endfunction


function GoToRemoteOrFile(line) abort
  let l:result = GetFileAndLineFromRemoteLink(a:line)

  if has_key(l:result, "line") && has_key(l:result, "file")
    execute "silent edit +" . l:result.line . " " . l:result.file
  elseif has_key(l:result, "file")
    execute "silent edit " . l:result.file
  else
   edit <cfile>
  endif
endfunction
" overrides default gf behavior to try to parse urls first
nnoremap gf :<c-u>call GoToRemoteOrFile(getline('.'))<cr>
