if exists(':Tagbar')
    nmap <F8> :TagbarToggle<CR>
    "autocmd FileType * nested :call tagbar#autoopen(0)
    "autocmd BufEnter * nested :call tagbar#autoopen(0)
end
