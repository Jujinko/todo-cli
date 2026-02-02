" ~/.vim/syntax/todo.vim

if exists("b:current_syntax")
  finish
endif

" Matches
" We use character classes [?] and [~] to force literal matching
syntax match TodoSection "^\[.*\]"
syntax match TodoDone "\[x\].*"
syntax match TodoUrgent "\[!\].*"
syntax match TodoQuestion "\[[?]\].*"
syntax match TodoCanceled "\[[\~]\].*"
syntax match TodoTable ".*|.*|.*"
syntax match TodoTicket "#[0-9]\+"

" Highlights
highlight TodoSection   ctermfg=Yellow gui=bold guifg=#fabd2f
highlight TodoDone      ctermfg=240 guifg=#585858
highlight TodoUrgent    ctermfg=White ctermbg=Red guifg=#ffffff guibg=#cc241d gui=bold
highlight TodoQuestion  ctermfg=Cyan guifg=#83a598
highlight TodoCanceled  ctermfg=DarkGray guifg=#928374 gui=strikethrough
highlight TodoTicket    ctermfg=141 guifg=#d3869b

let b:current_syntax = "todo"
