let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'c': ['clangd'],
    \ 'cpp': ['clangd'],
    \ 'objc': ['clangd'],
    \ 'objcpp': ['clangd'],
    \ 'css': ['css-languageserver ', '--stdio'],
    \ 'less': ['css-languageserver ', '--stdio'],
    \ 'sass': ['css-languageserver ', '--stdio'],
    \ 'dockerfile': ['docker-langserver ', '--stdio'],
    \ 'go': ['go-langserver', '-gocodecompletion'],
    \ 'javascript': ['flow', 'lsp'],
    \ 'javascript.jsx': ['flow', 'lsp'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
\ }

nnoremap <leader>c :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
