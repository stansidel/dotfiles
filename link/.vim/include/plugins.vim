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
Plug 'craigemery/vim-autotag' " See http://ricostacruz.com/til/navigate-code-with-ctags
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-surround'
Plug 'keith/swift.vim'
Plug 'vim-syntastic/syntastic'
Plug 'davidoc/taskpaper.vim'
if has('mac')
    Plug 'gfontenot/vim-xcode'
end
call plug#end()

" NERDTree
let NERDTreeShowHidden = 1
let NERDTreeMouseMode = 2
let NERDTreeMinimalUI = 1
map <leader>n :NERDTreeToggle<CR>
map <leader>N :NERDTreeFind<CR>
autocmd vimrc StdinReadPre * let s:std_in=1
" If no file or directory arguments are specified, open NERDtree.
" If a directory is specified as the only argument, open it in NERDTree.
autocmd vimrc VimEnter *
  \ if argc() == 0 && !exists("s:std_in") |
  \   NERDTree |
  \ elseif argc() == 1 && isdirectory(argv(0)) |
  \   bd |
  \   exec 'cd' fnameescape(argv(0)) |
  \   NERDTree |
  \ end

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

" Vim Autotag
let g:autotagTagsFile="tags"

" bkad/CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" syntastic
" https://stackoverflow.com/a/18234204/758990
let g:syntastic_cpp_compiler_options = ' -std=gnu++1z'