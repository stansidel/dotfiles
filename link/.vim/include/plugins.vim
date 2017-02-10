" https://github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Reload .vimrc and :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'parkr/vim-jekyll'
" Plug 'kannokanno/previm'
" Plug 'stansidel/previm', { 'branch': 'enhanced' }
Plug 'git@github.com:stansidel/previm.git', { 'branch': 'enhanced' }
" if has('mac')
"   Plug 'junegunn/vim-xmark'
" else
"   Plug 'JamshedVesuna/vim-markdown-preview'
" endif
Plug 'blindFS/vim-reveal'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

" previm
let g:previm_open_cmd = 'open -a Safari'

" Vim Reveal
let g:reveal_config = {
    \'path': '$HOME/.vim/files/reveal.js/'}

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" See http://stackoverflow.com/a/21891088/758990
let g:NERDTreeChDirMode       = 2
let g:ctrlp_working_path_mode = 'rw'
"let g:ctrlp_working_path_mode = 'ra'
if executable('ag')
  " if ag is used, the following CtrlP options are ignored: ctrlp_show_hidden ctrlp_custom_ignore and vim's wildignore
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif
let g:ctrlp_show_hidden = 1
