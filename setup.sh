#!/bin/sh
DOTFILES="$(dirname "$0")"

# ZSH + misc stuff
ln -s "$DOTFILES/zsh/zshrc"            "$HOME/.zshrc"
ln -s "$DOTFILES/lessrc"               "$HOME/.lessrc"

# VIM
ln -s "$DOTFILES/vim"                  "$HOME/.vim"
ln -s "$HOME/.vim/vimrc"               "$HOME/.vimrc"

# Tmux
ln -s "$DOTFILES/tmux"                 "$HOME/.tmux"
ln -s "$HOME/.tmux/tmux.conf"          "$HOME/.tmux.conf"

# GIT
ln -s "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"

# rxvt-unicode
ln -s "$DOTFILES/urxvt"                "$HOME/.urxvt"
ln -s "$DOTFILES/Xresources"           "$HOME/.Xresources"
