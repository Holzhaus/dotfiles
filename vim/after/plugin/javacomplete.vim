if exists('g:JavaComplete_PluginLoaded')
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    let g:JavaComplete_JavaCompiler='/usr/bin/javac'
endif
