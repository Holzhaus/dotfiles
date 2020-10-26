if exists(":Neomake")
    autocmd! BufWritePost,BufEnter * Neomake
endif
