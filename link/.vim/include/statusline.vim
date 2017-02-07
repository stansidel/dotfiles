" Always show status line
set laststatus=2
set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)
set statusline+=\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}
