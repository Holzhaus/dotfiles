set nocompatible              " be iMproved, required
filetype off                  " required

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
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'benmills/vimux'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
if has("python3") && has("nvim")
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'Shougo/deoplete.nvim', { 'do': function('UpdateRPlugin') }
    Plug 'zchee/deoplete-jedi'
    Plug 'zchee/deoplete-clang'
    Plug 'artur-shaik/vim-javacomplete2'
endif

" All of your Plugs must be added before the following line
call plug#end()            " required
