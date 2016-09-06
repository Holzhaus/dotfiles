#!/bin/sh
DOTFILES="$(dirname "$0")"

# ZSH
ln -s "$DOTFILES/zsh/zshrc"            "$HOME/.zshrc"

# VIM
ln -s "$DOTFILES/vim"                  "$HOME/.vim"
ln -s "$HOME/.vim/vimrc"               "$HOME/.vimrc"

# Tmux
ln -s "$DOTFILES/tmux"                 "$HOME/.tmux"
ln -s "$HOME/.tmux/tmux.conf"          "$HOME/.tmux.conf"

# GIT
ln -s "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"
