" CTRLP emulation
command! ProjectFiles execute 'Files' FindRootDirectory()
nmap <C-p> :ProjectFiles<CR>

if executable('rg')
    let $FZF_DEFAULT_COMMAND = '
      \ rg --files --hidden
      \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
      \ -g "!*.{min.js,swp,o,obj,exe,zip}"
      \ -g "!{.git,node_modules,vendor}/*" '

    let g:rg_command = '
      \ rg --column --line-number --no-heading --ignore-case --hidden --follow --color "always"
      \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
      \ -g "!*.{min.js,swp,o,obj,exe,zip}"
      \ -g "!{.git,node_modules,vendor}/*" '

    command! -bang -nargs=* Find call fzf#vim#grep(g:rg_command .shellescape(<q-args>).' 2>/dev/null', 0, { 'dir': FindRootDirectory() }, <bang>0)

    nmap <C-n> :Find<CR>
endif
