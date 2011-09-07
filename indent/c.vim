" Vim indent file
" Language:	C
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jun 12

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" C indenting is built-in, thus this is very simple
setlocal cindent

set list

"set for savevers.vim
"set backup
"set patchmode=.clean
"let savevers_types = "*.c,*.h"
"let savevers_dirs = &backupdir
"let versdiff_no_resize=1
nmap <silent> <F5> :VersDiff -<cr>
nmap <silent> <F6> :VersDiff +<cr>
nmap <silent> <F8> :VersDiff -c<cr>
