" curl https://raw.githubusercontent.com/blerins/flattown/master/colors/flattown.vim > $HOME/BASH/vim/my_runtime/colors/flattown.vim
let g:colors_name = "color_overrides"
hi SpecialComment guifg=#60666b guibg=NONE guisp=NONE gui=NONE ctermfg=242 ctermbg=NONE cterm=NONE
hi MatchParen cterm=bold,underline ctermbg=none ctermfg=none
hi SpellBad ctermbg=124 ctermfg=231
hi DiffText guifg=NONE guibg=#2E4052 guisp=#2E4052 gui=bold ctermfg=NONE ctermbg=239 cterm=bold
hi DiffAdd    guifg=#f8f8f8 guibg=#487a1a guisp=#487a1a gui=bold ctermfg=15 ctermbg=2 cterm=bold
hi DiffDelete guifg=#f8f8f8 guibg=#8F433D guisp=#8F433D gui=bold ctermfg=15 ctermbg=95 cterm=NONE
hi DiffChange guifg=#000000 guibg=#8F433D guisp=#8F433D gui=bold ctermfg=0 ctermbg=228 cterm=NONE
hi link markdownCodeDelimiter Delimiter
hi link markdownCode String
hi link markdownCodeBlock String
