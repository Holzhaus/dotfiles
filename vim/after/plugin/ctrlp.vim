if exists('g:loaded_ctrlp')
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
endif
