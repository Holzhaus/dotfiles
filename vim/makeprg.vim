augroup buildsystems
    autocmd!
    autocmd FileType c,cpp setlocal makeprg=make
    autocmd FileType python setlocal makeprg=python\ %
    autocmd FileType plaintex setlocal makeprg=make\ %:t:r.pdf
    autocmd FileType sh setlocal makeprg=sh\ %
    autocmd FileType perl,pm setlocal makeprg=perl\ %
    autocmd FileType scheme,scm,scsh setlocal makeprg=bash\ -c\ ./%
    autocmd FileType ruby,rb setlocal makeprg=ruby\ %
    autocmd FileType java setlocal makeprg=javac\ %\ &&\ java\ -cp\ %:p:h\ %:t:r
augroup END
