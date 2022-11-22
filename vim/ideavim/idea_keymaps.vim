" to search in aswb use :actionlist <search>
" https://gist.github.com/zchee/9c78f91cc5ad771c1f5d

nnoremap gd :action GotoDeclaration<CR>
nnoremap gs :action GotoSuperMethod<CR>
nnoremap gm :action GotoImplementation<CR>
nnoremap gu :action FindUsages<CR>
nnoremap gr :action ShowUsages<CR>
nnoremap [e :action JumpToLastChange<CR>
nnoremap ]e :action JumpToNextChange<CR>
nnoremap [c :action VcsShowPrevChangeMarker<CR>
nnoremap ]c :action VcsShowNextChangeMarker<CR>
"show diff doesnt seem to work but rollback does
nnoremap <space>d :action Vcs.ShowDiffWithLocal<CR>
nnoremap <space><C-d> :action Vcs.RollbackChangedLines<CR>
