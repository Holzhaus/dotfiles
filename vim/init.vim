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
if filereadable(expand("~/.vim/plugins.vim"))
    source ~/.vim/plugins.vim
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
    colorscheme monokain
    "highlight Normal ctermbg=230
    highlight Visual ctermbg=237
    "highlight NonText ctermbg=234
catch /^Vim\%((\a\+)\)\=:E185/
    " Nothing to do here
endtry

" Transparent background
if !has('gui_running')
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
endif

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
"set ttyfast
"set lazyredraw

" Real time regex highlighting
set incsearch
set hlsearch
if has("nvim")
    set inccommand=split
endif

" Conceal settings
set concealcursor=

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

" Only highlight the first 500 chars of a file (Performance)
set synmaxcol=2000

" Better copy & paste
set pastetoggle=<F2>
set clipboard=unnamed

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set tabstop=4
"set textwidth=72
set expandtab

" Show Tabs and EOL
if has("multi_byte") && ( has("nvim") || &termencoding == "utf-8" )
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
if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
endif

" Enable Modelines
set modeline

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AddModeline()
  let l:modeline = printf(" vim: set ft=%s ff=%s ts=%d sw=%d tw=%d %set :",
              \ &filetype, &fileformat, &tabstop, &shiftwidth, &textwidth,
              \ &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AddModeline()<CR>

" Reset terminal after leaving VIM
"if !has('gui_running')
"    au VimLeave * !echo -ne "\033[0m"
"endif

" Airline settings
let g:airline_theme = 'murmur'
let g:airline_powerline_fonts = 0

" CtrlP settings
let g:ctrlp_cmd = 'CtrlPMixed'

" Workaround for Git-Fugitive not starting in insert mode
" See: https://github.com/tpope/vim-fugitive/issues/957
if has("nvim")
    augroup nvim_term
      au!
      au TermOpen * startinsert
      au TermClose * stopinsert
    augroup END
endif

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ALE support
let g:ale_completion_enabled = 0

" rooter
let g:rooter_manual_only = 1
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['Makefile', 'Rakefile', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']

" Vimwiki
let g:vimwiki_list = [{ 'path': '~/.vimwiki/', 'ext': '.md', 'auto_toc': 1, 'auto_tags': 1, 'syntax': 'markdown' }]
