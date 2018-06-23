set nocompatible              " be iMproved, required
filetype off                  " required

if filereadable(expand('~/.vim/autoload/plug.vim'))
" Neovim rplugin update
function! UpdateRPlugin(info)
  if has('nvim')
    silent UpdateRemotePlugins
    echomsg 'rplugin updated: ' . a:info['name'] . ', restart vim for changes'
  endif
endfunction

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sickill/vim-monokai'
Plug 'majutsushi/tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'davidhalter/jedi-vim'
Plug 'airblade/vim-rooter'
Plug 'tweekmonster/fzf-filemru'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
if has("python3") && has("nvim")
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'honza/vim-snippets'
    Plug 'Shougo/deoplete.nvim', { 'do': function('UpdateRPlugin') }
    Plug 'zchee/deoplete-jedi'
    Plug 'zchee/deoplete-clang'
    Plug 'artur-shaik/vim-javacomplete2'
endif

" All of your Plugs must be added before the following line
call plug#end()            " required
endif
