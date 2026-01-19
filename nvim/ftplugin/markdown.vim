setlocal expandtab
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal autoindent

if has('conceal')
    setlocal conceallevel=0
endif

if executable("pandoc")
    fun! Pandoc(template) "{{{
        if empty(a:template)
            execute "!pandoc --output=" . expand("%:r") . ".pdf " . expand("%")
        else
            execute "!pandoc --template=" . a:template . " --output=" . expand("%:r") . ".pdf " . expand("%")
        endif
    endfunction "}}}

    command! -buffer -nargs=* Pandoc call Pandoc('<args>')
    nnoremap <buffer> <Leader>pn :call Pandoc(v:null)<CR>
    nnoremap <buffer> <Leader>pl :call Pandoc('letter.latex')<CR>
    nnoremap <buffer> <Leader>ps :call Pandoc('org-memo.latex')<CR>
    nnoremap <buffer> <Leader>pd :call Pandoc('org-memo2.latex')<CR>
endif
