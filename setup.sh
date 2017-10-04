#!/bin/sh
abspath() {
    olddir=$(pwd)
    if [[ -d "$1" ]]; then
        cd "$1"
        echo "$(pwd -P)"
    else
        cd "$(dirname "$1")"
        echo "$(pwd -P)/$(basename "$1")"
    fi
    cd "$olddir"
}

: "${HOME?Need to set HOME}"
DOTFILES="$(abspath "$(dirname "$0")")"

# Logging
exec 3>&1
log ()
{
    echo "$1" 1>&3
}

# Installation
symlink() {
    if [ -L "$2" ]; then
    # FIXME: readlink -m is not POSIX compliant
        if [ "$(readlink -m "$2")" != "$1" ]; then
            log "Deleting old symlink '$2' (pointed to '$(readlink "$2")')"
            rm "$2"
            ln -s "$1" "$2"
        fi
    elif [ ! -e "$2" ]; then
       log "File '$2' does not exist, creating symlink..."
       ln -s "$1" "$2"
    elif [ -e "$2" -a ! -e "$2.old" ]; then
        log "Creating Backup for '$2' -> '$2.old'"
        mv "$2" "$2.old"
        ln -s "$1" "$2"
    else
        log "Unable to install '$2'"
    fi
}

# Less
symlink "$DOTFILES/lessrc"               "$HOME/.lessrc"

# VIM
symlink "$DOTFILES/vim"                  "$HOME/.vim"
symlink "$HOME/.vim/init.vim"            "$HOME/.vimrc"
symlink "$HOME/.vim"                     "$HOME/.config/nvim"

# Tmux
symlink "$DOTFILES/tmux"                 "$HOME/.tmux"
symlink "$HOME/.tmux/tmux.conf"          "$HOME/.tmux.conf"

# GIT
symlink "$DOTFILES/git/gitconfig"        "$HOME/.gitconfig"
symlink "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"

# rxvt-unicode
symlink "$DOTFILES/urxvt"                "$HOME/.urxvt"

# alacritty
symlink "$DOTFILES/alacritty"            "$HOME/.config/alacritty"

# Bash
symlink "$DOTFILES/bash/bashrc"          "$HOME/.bashrc"
symlink "$DOTFILES/bash/bash_logout"     "$HOME/.bash_logout"
symlink "$DOTFILES/bash/bash_profile"    "$HOME/.bash_profile"

# inputrc
symlink "$DOTFILES/inputrc"              "$HOME/.inputrc"

# Python
symlink "$DOTFILES/python/pythonrc.py"   "$HOME/.pythonrc.py"

# rofi
symlink "$DOTFILES/rofi"                 "$HOME/.rofi"

# Xresources
symlink "$DOTFILES/Xresources"           "$HOME/.Xresources"
