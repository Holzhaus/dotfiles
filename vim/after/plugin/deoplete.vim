if exists('g:loaded_deoplete')
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1

    inoremap <expr><C-h>
          \ deolete#mappings#smart_close_popup()."\<C-h>"
    inoremap <expr><BS>
          \ deoplete#mappings#smart_close_popup()."\<C-h>"

    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif

    if exists('g:JavaComplete_PluginLoaded')
        let g:deoplete#omni#input_patterns.java = '[^. *\t]\.\w*'
    endif

    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | silent! pclose | endif
    " Set minimum syntax keyword length.
    let g:deoplete#sources#syntax#min_keyword_length = 2

    let g:deoplete#sources#jedi#show_docstring = 1

    call deoplete#enable()
endif
