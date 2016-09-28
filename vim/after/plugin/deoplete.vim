if exists('g:loaded_deoplete')
    " Use deoplete.
    let g:deoplete#enable_at_startup = 1
    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif

    " Disable auto-complete
    " let g:deoplete#disable_auto_complete = 1
    inoremap <expr><C-n> deoplete#mappings#manual_complete()

    " Automaticcaly close scratch window when finishing complete
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endif
