" --- Search docsets for something you type
" search related docsets
nnoremap <Leader>k :Dasht<Space>
" search ALL the docsets
nnoremap <Leader><Leader>k :Dasht!<Space>

" --- Search docsets for words under cursor
" search related docsets
nnoremap <Leader>K :call Dasht(dasht#cursor_search_terms())<Return>
" search ALL the docsets
nnoremap <Leader><Leader>K :call Dasht(dasht#cursor_search_terms(), '!')<Return>

" --- Search docsets for your selected text:
" search related docsets
vnoremap <Leader>K y:<C-U>call Dasht(getreg(0))<Return>

" search ALL the docsets
vnoremap <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

let g:dasht_filetype_docsets = {}
 " When in nasm, also search Intel_x86_IA32 docs:
let g:dasht_filetype_docsets['nasm'] = ['Intel_x86_IA32']
let g:dasht_filetype_docsets['c'] = ['C', 'Qt_5', 'Qt_6', 'Intel_x86_IA32', 'msdn']
let g:dasht_filetype_docsets['cpp'] = ['^C++', 'Qt_5', 'Qt_6', 'boost', 'Intel_x86_IA32', 'msdn']
let g:dasht_filetype_docsets['python'] = ['(num|sci)py', 'pandas', 'requests']
let g:dasht_filetype_docsets['html'] = ['css', 'js', 'bootstrap']
let g:dasht_filetype_docsets['java'] = ['Java_SE11', 'JUnit5']

let g:dasht_results_window = 'botright vnew'
