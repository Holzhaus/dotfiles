#
# ~/.profile
#

# User-local profile files
: "${HOME?Need to set HOME}"
if [ -d "$HOME/.profile.d" ]
then
    for f in "$HOME/.profile.d/"?*
    do
        logger --id=$$ "Sourcing file: $f"
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# XDG
export XDG_CONFIG_HOME="$HOME/.config"

# Use nvim/vim/vi as default editor
if command -v "nvim" >/dev/null 2>&1; then
    export EDITOR="nvim"
    export VISUAL="nvim"
else
    if command -v "vim" >/dev/null 2>&1; then
        export EDITOR="vim"
        export VISUAL="vim"
    else
        export EDITOR="vi"
        export VISUAL="vi"
    fi
fi

# Use less as pager
if command -v "less" >/dev/null 2>&1; then
    export PAGER="less"
fi

# Load less pager config
if [[ -r "$HOME/.lessrc" ]]; then
    source "$HOME/.lessrc"
fi

if command -v "qutebrowser" >/dev/null 2>&1; then
    export GUIBROWSER=qutebrowser
elif command -v "firefox" >/dev/null 2>&1; then
    export GUIBROWSER=firefox
fi

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Setup python startup config
export PYTHONSTARTUP=$HOME/.pythonrc.py

# Setup ruby gem path
if command -v 'ruby' >/dev/null 2>&1; then
    export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
fi

if [ -d "$HOME/.texmf" ]; then
    export TEXMFHOME="$HOME/.texmf"
fi

# Set up terminal emulator
if command -v "alacritty" >/dev/null 2>&1; then
    export TERMINAL="alacritty"
fi

export MPD_HOST="raspberrypi-4b.lan"
export MPD_LIBRARY_PATH=/data/music/

export KODI_HOST="raspberrypi-4b.lan"
