:set number
:set backspace=indent,eol,start
:syntax on
:set ruler
:set backup
:set backupdir=$HOME/.vim/backup
:set background=dark
:set showcmd
:set incsearch
:set hlsearch
:set autoindent
:set nocindent
:set smartindent
:set copyindent
:set showmode
":set foldmethod=syntax
:set foldnestmax=5
:set shiftwidth=4
:set tabstop=4
:set expandtab
:set showtabline=2
:set filetype=on
:set shortmess=a

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo"

let g:PathToSessions=$HOME . "/.vim/sessions/"

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

:set makeprg=[[\ -f\ Makefile\ ]]\ &&\ make\ \\\|\\\|\ make\ -C\ ..
