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
[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME="$HOME/.config"
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
symlink "$HOME/.vim"                     "$XDG_CONFIG_HOME/nvim"

# Tmux
symlink "$DOTFILES/tmux"                 "$HOME/.tmux"
symlink "$HOME/.tmux/tmux.conf"          "$HOME/.tmux.conf"

# GIT
symlink "$DOTFILES/git/gitconfig"        "$HOME/.gitconfig"
symlink "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"

# rxvt-unicode
symlink "$DOTFILES/urxvt"                "$HOME/.urxvt"

# alacritty
symlink "$DOTFILES/alacritty"            "$XDG_CONFIG_HOME/alacritty"

# Bash
symlink "$DOTFILES/bash/bashrc"          "$HOME/.bashrc"
symlink "$DOTFILES/bash/bash_logout"     "$HOME/.bash_logout"
symlink "$DOTFILES/bash/bash_profile"    "$HOME/.bash_profile"

# i3-gaps config
symlink "$DOTFILES/i3"                   "$HOME/.i3"

# autorandr
symlink "$DOTFILES/autorandr"            "$XDG_CONFIG_HOME/autorandr"

# compton
symlink "$DOTFILES/compton/compton.conf" "$HOME/.compton.conf"

# dunst
symlink "$DOTFILES/dunst"                "$XDG_CONFIG_HOME/dunst"

# inputrc
symlink "$DOTFILES/inputrc"              "$HOME/.inputrc"

# LatexMK
symlink "$DOTFILES/latexmkrc"            "$HOME/.latexmkrc"

# ncmpcpp
symlink "$DOTFILES/ncmpcpp"              "$XDG_CONFIG_HOME/ncmpcpp"

# nitrogen
symlink "$DOTFILES/nitrogen"             "$XDG_CONFIG_HOME/nitrogen"

# polybar
symlink "$DOTFILES/polybar"              "$XDG_CONFIG_HOME/polybar"

# profile
symlink "$DOTFILES/profile"              "$HOME/.profile"

# Python
symlink "$DOTFILES/python/pythonrc.py"   "$HOME/.pythonrc.py"

# rofi
symlink "$DOTFILES/rofi"                 "$HOME/.rofi"

# xinitrc
symlink "$DOTFILES/xinitrc"              "$HOME/.xinitrc"

# Xresources
symlink "$DOTFILES/xcolors"              "$HOME/.xcolors"
symlink "$DOTFILES/Xresources"           "$HOME/.Xresources"

# Zathura
symlink "$DOTFILES/zathura"              "$XDG_CONFIG_HOME/zathura"
