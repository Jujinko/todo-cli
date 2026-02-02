" ~/.vimrc

" enable Filetype detection and plugins
filetype plugin indent on

" enable Syntax highlighting
syntax on

" detection rule
autocmd BufRead,BufNewFile */todo/daily/*.txt set filetype=todo
