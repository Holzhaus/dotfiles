set nocompatible              " be iMproved, required
filetype off                  " required

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'

" LSP / Linting
Plug 'w0rp/ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" Other stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-rooter'
Plug 'tweekmonster/fzf-filemru'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/DrawIt'
Plug 'sunaku/vim-dasht'

" All of your Plugs must be added before the following line
call plug#end()            " required
endif
