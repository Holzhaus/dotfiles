" Automatic Reloading of .vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
endif

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
set omnifunc=syntaxcomplete#Complete

" Color scheme
try
    colorscheme molokai
    "highlight Normal ctermbg=230
    highlight Visual ctermbg=237
    "highlight NonText ctermbg=234
catch /^Vim\%((\a\+)\)\=:E185/
    " Nothing to do here
endtry

highlight Statement cterm=italic
highlight Conditional cterm=italic
" highlight Comment cterm=italic
highlight SpecialComment cterm=italic

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Oh vim, don't be so slow,,,
set ttyfast
set lazyredraw

" Real time regex highlighting
set incsearch
set hlsearch
if has("nvim")
    set inccommand=split
endif

" Better command-line completion
set wildmenu

" Complete longest common string on first, then first match on second keypress
set wildmode=longest:full,full

" Show partial commands in the last line of the screen
set showcmd

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Indentation-aware line wrapping
set breakindent

" Use visual bell instead of beeping when doing something wrong
set novisualbell

" Display line numbers on the left
set number
set norelativenumber

" Highlight Column
set colorcolumn=80
"highlight ColorColumn ctermbg=235
highlight ColorColumn ctermbg=235

" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Only highlight the first 200 chars of a file (Performance)
set synmaxcol=200

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
if has("multi_byte") && &termencoding == "utf-8"
    set list
    set listchars=tab:▹\ ,space:·,nbsp:␣
    set showbreak=↪\ 
endif

" Better colors when matching braces
hi MatchParen cterm=bold ctermbg=none ctermfg=magenta

" Better Indentation of code blocks
vnoremap < <gv
vnoremap > >gv

" Auto Formatting
if executable('xmlstarlet')
    au FileType xml setlocal equalprg=xmlstarlet\ fo\ -R\ -\ 2>/dev/null
    au FileType html setlocal equalprg=xmlstarlet\ fo\ -R\ -H\ -\ 2>/dev/null
endif

" Nicer netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
set autochdir
nnoremap <F3> :Lexplore<CR>

" Persistent undo
set undofile
set undodir=~/.vim/undodir

" Enable Modelines
set modeline

" Airline settings
let g:airline_theme = 'murmur'
let g:airline_powerline_fonts = 0

" CtrlP settings
let g:ctrlp_cmd = 'CtrlPMixed'

" Workaround for Git-Fugitive not starting in insert mode
" See: https://github.com/tpope/vim-fugitive/issues/957
augroup nvim_term
  au!
  au TermOpen * startinsert
  au TermClose * stopinsert
augroup END
