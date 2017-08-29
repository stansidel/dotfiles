" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

" Local dirs
if !has('win32')
  set backupdir=$DOTFILES/caches/vim
  set directory=$DOTFILES/caches/vim
  set undodir=$DOTFILES/caches/vim
  let g:netrw_home = expand('$DOTFILES/caches/vim')
endif

" Create vimrc autocmd group and remove any existing vimrc autocmds,
" in case .vimrc is re-sourced.
augroup vimrc
  autocmd!
augroup END

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set backupdir=~/.vim/backups
silent !mkdir ~/.vim/swaps > /dev/null 2>&1
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Clear last search
map <silent> <leader>/ <Esc>:nohlsearch<CR>

" Ignore things
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/log/*,*/tmp/*

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set tabstop=2
" Replace tabs with spaces
set expandtab
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" When editing a file, always jump to the last known cursor position. Don't do
" it for commit messages, when the position is invalid, or when inside an event
" handler (happens when dropping a file on gvim).
autocmd vimrc BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" F10: Source .vimrc & .gvimrc files
nmap <F10> :call SourceConfigs()<CR>

if !exists("*SourceConfigs")
  function! SourceConfigs()
    let files = ".vimrc"
    source $MYVIMRC
    if has("gui_running")
      let files .= ", .gvimrc"
      source $MYGVIMRC
    endif
    echom "Sourced " . files
  endfunction
endif

" F7: Paste a random commit message
nmap <F7> :.-1read !curl -s "http://whatthecommit.com/index.txt"<CR> 

" Ctrl-J/K/L/H select split
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Buffer navigation
nnoremap <leader>b :CtrlPBuffer<CR> " List other buffers
map <leader><leader> :b#<CR> " Switch between the last two files
map gb :bnext<CR> " Next buffer
map gB :bprev<CR> " Prev buffer

" FILE TYPES

autocmd vimrc BufRead .vimrc,*.vim set keywordprg=:help
autocmd vimrc BufRead,BufNewFile *.md set filetype=markdown
autocmd vimrc BufRead,BufNewFile *.tmpl set filetype=html

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif
set tabstop=4 shiftwidth=4 expandtab autoindent smartindent
" https://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc secure

" Russian language. See https://habrahabr.ru/post/98393/
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
imap <C-f> <C-^>
setlocal spell spelllang=ru_yo,en_us

" Build and run certian files
autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%:p')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%:p:h').'/*.cpp -o '.shellescape('%:p:r').' && (cd '.shellescape('%:p:h').' && exec '.shellescape('%:p:r').' && cd -) && rm '.shellescape('%:p:r')<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%:p:h').'/*.cpp -o '.shellescape('%:p:r').' -std=gnu++1z && (cd '.shellescape('%:p:h').' && exec '.shellescape('%:p:r').' && cd -) && rm '.shellescape('%:p:r')<CR>

source $HOME/.vim/include/plugins.vim
source $HOME/.vim/include/statusline.vim
source $HOME/.vim/include/visual-at.vim