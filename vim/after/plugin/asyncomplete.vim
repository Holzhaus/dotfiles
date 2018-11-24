" Enable preview window
set completeopt+=preview

" Auto close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

if exists('*asyncomplete#sources#file#completor')
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
        \ 'name': 'file',
        \ 'whitelist': ['*'],
        \ 'priority': 10,
        \ 'completor': function('asyncomplete#sources#file#completor')
        \ }))
endif

if exists('*asyncomplete#sources#neosnippet#completor')
    call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
        \ 'name': 'neosnippet',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
        \ }))
endif

if exists('*asyncomplete#sources#buffer#completor')
    call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['*'],
        \ 'blacklist': ['go'],
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \ }))
endif
