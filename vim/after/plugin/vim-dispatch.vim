if exists('g:loaded_dispatch')
    :noremap <buffer> <localleader>r :Make<CR>
else
    :noremap <buffer> <localleader>r :make<CR>
endif
