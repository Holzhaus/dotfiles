#!/bin/sh
abspath() {
    olddir=$(pwd)
    if [ -d "$1" ]; then
        cd "$1" || exit 1
        pwd -P
    else
        cd "$(dirname "$1")" || exit 1
        echo "$(pwd -P)/$(basename "$1")"
    fi
    cd "$olddir" || exit 1
}

: "${HOME?Need to set HOME}"

[ -z "$HOSTNAME" ] && HOSTNAME="$(hostname)"

[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"

[ -z "$XDG_DATA_HOME" ] && XDG_DATA_HOME="$HOME/.local/share"
mkdir -p "$XDG_DATA_HOME"

[ -z "$BINDIR" ] && BINDIR="$HOME/.local/bin"
mkdir -p "$BINDIR"

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
        # FIXME: We could use readlink's "-m" argument to follow deep symlinks
        # but it's not POSIX compliant
        if [ "$(readlink "$2")" != "$1" ]; then
            log "Deleting old symlink '$2' (pointed to '$(readlink "$2")')"
            rm "$2"
            ln -s "$1" "$2"
        fi
    elif [ ! -e "$2" ]; then
       log "File '$2' does not exist, creating symlink..."
       ln -s "$1" "$2"
    elif [ -e "$2" ] && [ ! -e "$2.old" ]; then
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
symlink "$HOME/.vim"                     "$XDG_CONFIG_HOME/nvim"

# Tmux
symlink "$DOTFILES/tmux"                 "$HOME/.tmux"
symlink "$HOME/.tmux/tmux.conf"          "$HOME/.tmux.conf"
symlink "$HOME/.tmux/tmux.conf.local"    "$HOME/.tmux.conf.local"

# GIT
symlink "$DOTFILES/git/gitconfig"        "$HOME/.gitconfig"
symlink "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"
symlink "$DOTFILES/git/gittemplate"      "$HOME/.gittemplate"

# Bash
symlink "$DOTFILES/bash/bashrc"          "$HOME/.bashrc"
symlink "$DOTFILES/bash/bash_logout"     "$HOME/.bash_logout"
symlink "$DOTFILES/bash/bash_profile"    "$HOME/.bash_profile"

# gdb
symlink "$DOTFILES/gdb"                  "$XDG_CONFIG_HOME/gdb"
symlink "$XDG_CONFIG_HOME/gdb/init.gdb"  "$HOME/.gdbinit"

# inputrc
symlink "$DOTFILES/inputrc"              "$HOME/.inputrc"

# LatexMK
symlink "$DOTFILES/latexmkrc"            "$HOME/.latexmkrc"

# ncmpcpp
symlink "$DOTFILES/ncmpcpp"              "$XDG_CONFIG_HOME/ncmpcpp"

# profile
symlink "$DOTFILES/profile"              "$HOME/.profile"

# Python
symlink "$DOTFILES/python/pythonrc.py"   "$HOME/.pythonrc.py"

# WeeChat
symlink "$DOTFILES/weechat"              "$HOME/.weechat"

for executable in "$DOTFILES/bin/"*
do
    if [ -x "$executable" ]
    then
        symlink "$executable" "$BINDIR/$(basename "$executable")"
    fi
done
