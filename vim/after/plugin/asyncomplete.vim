" Enable preview window
set completeopt+=preview

" Hide 'Pattern not found' messages
set shortmess+=c

" Force refresh completion
imap <c-space> <Plug>(asyncomplete_force_refresh)

" Auto close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

if exists('g:asyncomplete_loaded')
    call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'whitelist': ['*'],
        \ 'priority': 20,
        \ 'completor': function('asyncomplete#sources#file#completor')
        \ }))

    call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
        \ 'name': 'neosnippet',
        \ 'whitelist': ['*'],
        \ 'priority': 10,
        \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
        \ }))

    call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['markdown', 'vimwiki', 'text', 'latex', 'plaintex', 'make', 'gitcommit'],
        \ 'blacklist': ['go'],
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ }))
endif
