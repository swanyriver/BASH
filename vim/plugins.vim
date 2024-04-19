"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""vim plugins"""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: also inlcudes remaps specifc to plugins

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""  signify git-gutter and hunk operations """"""""""""""""
Plug 'mhinz/vim-signify'

nnoremap <space>d :SignifyHunkDiff<CR>
nnoremap <space><C-d> :SignifyHunkUndo<CR>

" hunk text object
omap ic <plug>(signify-motion-inner-pending)
xmap ic <plug>(signify-motion-inner-visual)
omap ac <plug>(signify-motion-outer-pending)
xmap ac <plug>(signify-motion-outer-visual)

let g:signify_priority = 1
let g:signify_skip_filetype = { 'gitcommit': 1}
let g:signify_skip_filetype = { 'hgcommit': 1}

"" show in number col also
let g:signify_number_highlight = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""airline statusbar""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""commentary"""comment and uncomment lines"""""""""""""""
Plug 'tpope/vim-commentary'
" Note: keybindings replaced by comment.nvim but Plug:Commentary used by yank-comment-paste
" TODO: replace dependency with api.comment, see :help comment-nvim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""surround"""""encapsulate with qoute and brackets""""""
Plug 'tpope/vim-surround'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""" https://github.com/wellle/targets.vim """"""""""""""""""""""""
Plug 'wellle/targets.vim'

""""""""""""""""""""""""""""toggle cursor"""""""""""""""""""""""""""""""
""" https://github.com/jszakmeister/vim-togglecursor
if !has('nvim')
  " had one local fix for the xterm check
" -    elseif s:GetXtermVersion($XTERM_VERSION) >= 252
" +    elseif s:GetXtermVersion(system('xterm -version')) >= 252
  " Plug '~/BASH/vim/plugins/vim-togglecursor'

  Plug 'jszakmeister/vim-togglecursor'
endif

"""""""""""""""""""""""""replace-with-register""""""""like my stamp plugin """"""""""
Plug 'inkarkat/vim-ReplaceWithRegister'
nmap <Leader>s  <Plug>ReplaceWithRegisterOperator
nmap <Leader>ss <Plug>ReplaceWithRegisterLine
xmap <Leader>s  <Plug>ReplaceWithRegisterVisual
" Replace rest of line, like Y, useful for replacing RHS
nnoremap <silent> <leader>S :<c-u>normal \s$<cr>


"""""""""""""""""""tpope/scriptese"""""" dsiable when not vim-deving """"""
" Plug 'tpope/vim-scriptease'


""""""""""""""""""""https://github.com/prabirshrestha/vim-lsp """"""
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
"let g:using_plugin_vim_lsp = 1


"" Title case "" https://github.com/christoomey/vim-titlecase
" gzz for line gz<motion>
Plug 'christoomey/vim-titlecase'


"" netrw replacement
"" - to go to buffer dir view
Plug 'tpope/vim-vinegar'
