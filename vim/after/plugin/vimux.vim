if exists('g:loaded_vimux')
    :noremap <buffer> <localleader>r :update<Bar>call VimuxRunCommandInDir("clear && " . join(map(split(substitute(&makeprg, '%', '%:t', '')), 'expand(v:val)')), 0)<CR>
else
    :noremap <buffer> <localleader>r <Nop>
endif

