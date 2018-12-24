" Automatically open quickfix window when AsyncRun command is executed
" set the quickfix window 6 lines height.
let g:asyncrun_open = 12

" ring the bell to notify you job finished
let g:asyncrun_bell = 1

command! -bang -nargs=* -complete=file -bar AsyncMake  AsyncRun<bang> -program=make -auto=make @ <args>
command! -bang -nargs=* -complete=file -bar AsyncGrep  AsyncRun<bang> -program=grep -auto=grep @ <args>

" F10 to toggle quickfix window
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

" F5 to run make
nnoremap <F5> :AsyncMake<cr>
