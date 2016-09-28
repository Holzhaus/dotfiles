" Automatic Reloading of .vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Load my plugins
if filereadable(expand("~/.vim/bundles.vim"))
    source ~/.vim/bundles.vim
endif

" Load make systems
if filereadable(expand("~/.vim/makeprg.vim"))
    source ~/.vim/makeprg.vim
endif

" Enable mouse support
" set mouse=a

" Make backspace behave normal
set bs=2

" Disable Arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>

" Remap leader key
let mapleader = ","
let maplocalleader = ","

" Save cursor position
augroup resCur
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" Enable syntax highlighting
filetype plugin on
syntax on

" Color scheme
try
    colorscheme molokai
    highlight Normal ctermbg=NONE
    highlight Visual ctermbg=232
    "highlight NonText ctermbg=234
endtry

highlight Statement cterm=italic
highlight Conditional cterm=italic
highlight Comment cterm=italic
highlight SpecialComment cterm=italic

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Oh vim, don't be so slow,,,
set ttyfast
set lazyredraw
autocmd VimEnter * redraw!

" Real time regex highlighting
set incsearch
set hlsearch

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Use visual bell instead of beeping when doing something wrong
set novisualbell

" Display line numbers on the left
set number
set norelativenumber

" Highlight Column
"set colorcolumn=80
let &colorcolumn=join(range(81,999),",")
"highlight ColorColumn ctermbg=235
highlight ColorColumn ctermbg=235

" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>


" Better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Show Tabs and EOL
set list
set listchars=tab:▹\ 

" Better colors when matching braces
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" Better Indentation of code blocks
vnoremap < <gv
vnoremap > >gv

" Trim trailing whitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

" Auto Formatting
if executable('xmlstarlet')
    au FileType xml setlocal equalprg=xmlstarlet\ fo\ -R\ -\ 2>/dev/null
    au FileType html setlocal equalprg=xmlstarlet\ fo\ -R\ -H\ -\ 2>/dev/null
endif
