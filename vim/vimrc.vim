" My runtimes (lua files mostly)
set runtimepath+=~/BASH/vim/my_runtime

" MY VIM CONFIGS
source $HOME/BASH/vim/settings.vim
source $HOME/BASH/vim/keymaps.vim

" fix tab close behavior
source $HOME/BASH/vim/tabcloseleft.vim

""""""" Plugins """""""""
" Using vim-plug:
" https://github.com/junegunn/vim-plug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Specify a directory for plugins
call plug#begin('~/BASH/vim/plugins/plugged')
  source $HOME/BASH/vim/plugins.vim
  if has('nvim')
    source $HOME/BASH/vim/plugins.nvim
  endif
" Initialize plugin system
call plug#end()

" Plugin settings
if exists("g:using_plugin_vim_lsp") && g:using_plugin_vim_lsp
  source $HOME/BASH/vim/lsp_settings.vim
endif
if exists("g:using_nvimlsp_and_nvimcmp") && g:using_nvimlsp_and_nvimcmp && has('nvim')
  " NOTE: this is the active one, see vim/plugins.nvim:47
  luafile $HOME/BASH/vim/nvimlsp_settings.lua
  luafile $HOME/BASH/vim/nvimcmp_settings.lua
  " TO add LSP make sure to do the following in lsp.setup
  "   * lsp.setup {  on_attach = require('my_nvimlsp_onattach') } vim/my_runtime/lua/my_nvimlsp_onattach.lua 
  "   * lsp.setup { capabilities = require('cmp_nvim_lsp').default_capabilities() } vim/nvimcmp_settings.lua
endif
if has('nvim')
  luafile $HOME/BASH/vim/plugin_settings.lua
endif

" Functions
source $HOME/BASH/vim/functions.vim
source $HOME/BASH/vim/shared_functions.vim
source $HOME/BASH/vim/quick_fix_tools.vim
source $HOME/BASH/vim/toggle_case.vim
source $HOME/BASH/vim/commentyankpaste.vim
source $HOME/BASH/vim/impl_header.vim
source $HOME/BASH/vim/autoignorecleanswaps.vim
source $HOME/BASH/vim/showkeymaps.vim
source $HOME/BASH/vim/autoimport.vim
source $HOME/BASH/vim/namevar.vim
source $HOME/BASH/vim/yanknote.vim
source $HOME/BASH/vim/send_to_tmux_and_clipboard.vim
source $HOME/BASH/vim/copyovercpp.vim

" NVIM specific
if has('nvim')
  source $HOME/BASH/vim/settings.nvim
endif

