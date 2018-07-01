if exists(':Dasht')
    " --- Search docsets for something you type
    " search related docsets
    nnoremap <Leader>k :Dasht<Space>
    " search ALL the docsets
    nnoremap <Leader><Leader>k :Dasht!<Space>

    " --- Search docsets for words under cursor
    " search related docsets
    nnoremap <silent> <Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>
    " search ALL the docsets
    nnoremap <silent> <Leader><Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>

    " --- Search docsets for your selected text:
    " search related docsets
    vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>

    " search ALL the docsets
    vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

    let g:dasht_filetype_docsets = {}
     " When in nasm, also search Intel_x86_IA32 docs:
    let g:dasht_filetype_docsets['nasm'] = ['Intel_x86_IA32']
endif
