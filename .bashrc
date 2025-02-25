#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
export XDG_CONFIG_HOME="$HOME/.config"
PS1='[\u@\h \W]\$ '

export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias fcd='cd "$(find $HOME -type d -name ".*" -or -name "*" | fzf)"'
alias qed='nvim "$(find $HOME/* -type f | fzf)"'

alias cpdir="pwd | xclip -selection c"
alias wcpdir="pwd | wl-copy"
alias serene="cd ~/Programming/repo/serene"
