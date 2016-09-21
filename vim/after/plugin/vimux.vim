if exists('g:loaded_vimux')
    :noremap <localleader>r <Nop>
    :autocmd Filetype python noremap <buffer> <localleader>r :update<Bar>call VimuxRunCommandInDir("clear && " . join(map(split(&makeprg), 'expand(v:val)')), 0)<CR>
endif

