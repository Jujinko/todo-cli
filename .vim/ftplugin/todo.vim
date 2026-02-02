" ~/.vim/ftplugin/todo.vim

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" ==============================================================================
"  LOGIC FUNCTIONS
" ==============================================================================

function! s:ToggleTodo()
    let l:line = getline('.')
    if l:line =~ '\[x\]'
        s/\[x\]/\[ \]/
    elseif l:line =~ '\[.\]'
        s/\[.\]/\[x\]/
    endif
    nohlsearch
    silent! call repeat#set("\<Plug>ToggleTodo", v:count)
endfunction

function! s:CycleTodoWeight()
    let l:line = getline('.')

    if l:line =~ '\[ \]'
        " [ ] -> [!]
        s/\[ \]/\[!\]/
        
    elseif l:line =~ '\[!\]'
        " [!] -> [?]
        " Use class [?] for safety in search
        s/\[!\]/\[?\]/
        
    elseif l:line =~ '\[[?]\]'
        " [?] -> [~]
        " CRITICAL FIX: The ~ in replacement must be escaped (\~)
        " otherwise it pastes the previous replacement string!
        s/\[[?]\]/\[\~\]/
        
    elseif l:line =~ '\[\~\]'
        " [~] -> [ ]
        s/\[\~\]/\[ \]/
    endif

    nohlsearch
    silent! call repeat#set("\<Plug>CycleTodoWeight", v:count)
endfunction

" ==============================================================================
"  MAPPINGS & SETTINGS
" ==============================================================================

nnoremap <silent> <buffer> <leader>x :call <SID>ToggleTodo()<CR>
vnoremap <silent> <buffer> <leader>x :call <SID>ToggleTodo()<CR>
nnoremap <silent> <buffer> <leader>w :call <SID>CycleTodoWeight()<CR>
vnoremap <silent> <buffer> <leader>t :!column -t -s '\|' -o '\|'<CR>
nnoremap <silent> <buffer> ]] :call search('^\[.*\]')<CR>
nnoremap <silent> <buffer> [[ :call search('^\[.*\]', 'b')<CR>
nnoremap <silent> <buffer> <C-k> :m .-2<CR>==
inoremap <silent> <buffer> <C-k> <Esc>:m .-2<CR>==gi
nnoremap <silent> <buffer> <C-j> <Esc>:m .+1<CR>==
inoremap <silent> <buffer> <C-j> <Esc>:m .+1<CR>==gi

iabbrev <expr> <buffer> xt strftime("%H:%M") . " \| "
iabbrev <expr> <buffer> xn "[" . strftime("%H:%M") . "]: "
iabbrev <expr> <buffer> xd strftime("%Y-%m-%d")

setlocal foldmethod=expr
setlocal foldexpr=getline(v:lnum)=~'^\\\[.*\\\]'?'>1':'='
setlocal foldlevel=99
