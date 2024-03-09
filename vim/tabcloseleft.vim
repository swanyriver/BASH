" Move to the left when closing a tab, as is correct
" from https://github.com/vim/vim/issues/5967
function! ShouldMoveToPreviousTab()
	" In some scenarios one field has the correct information, in other scearios the other has it
	let previousLastTabNr=max([g:TabLeave_TabsStatus.last, g:WinClosed_TabsStatus.last])
	return tabpagenr('$') < previousLastTabNr && g:TabLeave_TabsStatus.current != previousLastTabNr
endfunction

let g:WinClosed_TabsStatus = { 'current': 1, 'last': 1 } 
let g:TabLeave_TabsStatus =  { 'current': 1, 'last': 1 }
augroup tabcloseleft
	au!
	au TabLeave  * let g:TabLeave_TabsStatus  = { 'current': tabpagenr(), 'last': tabpagenr('$') }
	au WinClosed * let g:WinClosed_TabsStatus = { 'current': tabpagenr(), 'last': tabpagenr('$') }
	au TabClosed * if ShouldMoveToPreviousTab() | tabprevious | endif
augroup end
