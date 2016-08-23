##
#  Color support
##

autoload -U colors
colors

##
# SSH
##

function ssh_prompt_color() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo '%{%F{cyan}%}'
  else
    echo '%{%F{blue}%}'
  fi
}

##
# Background Jobs indicator
##

# https://gist.github.com/remy/6079223
function background_jobs() {
  [[ $(jobs -l | wc -l) -gt 0 ]] && echo "⚙"
}

##
# VIM Mode Prompt (with Dollar Sign)
##

vim_ins_mode="%{$fg[cyan]%}%(!.#.$)%{$reset_color%}"
vim_cmd_mode="%{$fg[red]%}%(!.#.$)%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-init zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-init
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
# Thanks Ron! (see comments)
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

PROMPT='
[%D{%H:%M}] %(!.%{$fg[red]%}.%{$fg[green]%})%n$(ssh_prompt_color)@%m%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%} %{$fg[white]%}$(background_jobs)%{$reset_color%}
${vim_mode} '

