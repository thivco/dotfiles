#
# ~/.bashrc
#
eval "$(starship init bash)"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias l='ls -lah --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias lab="cd ~/workshop/lab"
alias ws="cd ~/workshop"
alias ebashrc="nvim ~/workshop/lab/dotfiles/.bashrc && source ~/,bashrc"
alias ehc="nvim ~/workshop/lab/dotfiles/hypr/hyprland.conf"
pfetch
