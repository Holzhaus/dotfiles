#!/bin/sh
DOTFILES="$(dirname "$0")"

# ZSH
ln -s "$DOTFILES/.zsh/zshrc"           "$HOME/.zshrc"

# VIM
ln -s "$DOTFILES/vim"                  "$HOME/.vim"
ln -s "$HOME/.vim/vimrc"               "$HOME/.vimrc"
