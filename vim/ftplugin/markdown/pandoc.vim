if executable("pandoc")
    fun! Pandoc(template) "{{{
        if empty(a:template)
            execute "!pandoc --output=" . expand("%:r") . ".pdf " . expand("%")
        else
            execute "!pandoc --template=" . a:template . " --output=" . expand("%:r") . ".pdf " . expand("%")
        endif
    endfunction "}}}

    command! -buffer -nargs=* Pandoc call Pandoc('<args>')
    nnoremap <buffer> <LocalLeader>p :call Pandoc(v:null)<CR>
    nnoremap <buffer> <LocalLeader>l :call Pandoc('letter.latex')<CR>
    nnoremap <buffer> <LocalLeader>s :call Pandoc('org-memo.latex')<CR>
endif
