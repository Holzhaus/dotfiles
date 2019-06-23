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
    nnoremap <buffer> <LocalLeader>pn :call Pandoc(v:null)<CR>
    nnoremap <buffer> <LocalLeader>pl :call Pandoc('letter.latex')<CR>
    nnoremap <buffer> <LocalLeader>ps :call Pandoc('org-memo.latex')<CR>
endif
