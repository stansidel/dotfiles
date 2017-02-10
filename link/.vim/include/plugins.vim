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
call plug#end()

" previm
let g:previm_open_cmd = 'open -a Safari'

" Vim Reveal
let g:reveal_config = {
    \'path': '$HOME/.vim/files/reveal.js/'}
