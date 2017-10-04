set nocompatible              " be iMproved, required
filetype off                  " required

if exists('g:loaded_plug')
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
Plug 'neomake/neomake'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'tpope/vim-dispatch'
Plug 'majutsushi/tagbar'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
if has("python3") && has("nvim")
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'honza/vim-snippets'
    Plug 'Shougo/deoplete.nvim', { 'do': function('UpdateRPlugin') }
    Plug 'zchee/deoplete-jedi'
    Plug 'tweekmonster/deoplete-clang2'
    Plug 'artur-shaik/vim-javacomplete2'
endif

" All of your Plugs must be added before the following line
call plug#end()            " required
endif
