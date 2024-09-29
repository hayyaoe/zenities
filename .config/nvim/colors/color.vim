source ~/.cache/wal/colors-wal.vim

let g:colors_name = "color"

" Normal text
hi Normal guifg=s:foreground guibg=s:background

" Cursor color
hi Cursor guifg=s:background guibg=s:cursor

" Line numbers
hi LineNr guifg=s:color8 guibg=NONE

" Comment color
hi Comment guifg=s:color2 gui=italic

" Strings
hi String guifg=s:color4 guibg=NONE

" Functions
hi Function guifg=s:color5 guibg=NONE

" Keywords
hi Keyword guifg=s:color9 guibg=NONE

" Constants
hi Constant guifg=s:color11 guibg=NONE

" Visual mode selection
hi Visual guibg=s:color1 guifg=s:foreground

" Search
hi Search guifg=s:background guibg=s:color5

" Status line
hi StatusLine guifg=s:foreground guibg=s:color3

" VertSplit
hi VertSplit guifg=s:color3 guibg=s:background
