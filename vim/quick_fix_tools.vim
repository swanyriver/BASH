" Remaps for jumping quick fix and location list
" page up and page down for next and previous error
nnoremap <silent> <PageUp> :lprevious<cr>
nnoremap <silent> <PageDown> :lnext<cr>
nnoremap <silent> <C-PageUp> :cprevious<cr>
nnoremap <silent> <C-PageDown> :cnext<cr>

"""""""""""""""  GREP (rg) """""""""""""""""""""""""""""""""""""""""""""""""""
" allow for later sourced to conditionaly redifine search command and wrap with qoutes
let g:myqf_grepprg = &grepprg . " -F"

function! s:BackgroundGrep(grep_args_list)
  let l:search_query =  a:grep_args_list[0]

  " escapes first arg, the search pattern
  echom "[SEARCHCMD] " . join([g:myqf_grepprg] + [join([shellescape(l:search_query)] + a:grep_args_list[1:], ' ')], ' ')
  return system(join([g:myqf_grepprg] + [join([shellescape(l:search_query)] + a:grep_args_list[1:], ' ')], ' '))
endfunction

function! s:CSilentGrep(...)
  cgetexpr <SID>BackgroundGrep(a:000)
  echom "Found results: " . len(getqflist()) . "  " . join(a:000)
  copen
endfunction

function! s:LSilentGrep(...)
  tab split
  vsplit
  lgetexpr <SID>BackgroundGrep(a:000)
  echom "found results: " . len(getloclist(win_getid())) . "  " . join(a:000)
  lopen
  lfirst
endfunction

command! -nargs=+ -complete=file_in_path -bar CGrep  call <SID>CSilentGrep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar Grep call <SID>LSilentGrep(<f-args>)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:GrepOperator(type)
  let saved_unnamed_register = @@

  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif

  echom "searching for: " . @@
  call <SID>LSilentGrep(@@)

  let @@ = saved_unnamed_register
endfunction

nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
" extra <cr> to dismiss found message but still have them in :messages
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr><cr>

function! s:GitDiffQuickFix(...)
  let l:prg = "source ".$HOME."/BASH/_autogit; quickfix_git_diff"
  " true if there are optional args and the first one is truthy
  " diff against main branch
  if a:0 && a:1
    let l:prg .= " $(gain)"
  endif

  tab new
  lgetexpr system(l:prg)
  lopen
  lfirst
endfunction

nnoremap <leader>d :call <SID>GitDiffQuickFix()<CR>
" diff against main branch
nnoremap <leader>dm :call <SID>GitDiffQuickFix(1)<CR>

