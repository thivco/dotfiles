#
# ~/.bashrc
#
eval "$(starship init bash)"
source "$(fzf-share)/key-bindings.bash"
source "$(fzf-share)/completion.bash"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias l='ls -lah --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Create a dedicated virt bash script to run at boot

alias dot="cd ~/workshop/lab/dotfiles"
alias lab="cd ~/workshop/lab"
alias ws="cd ~/workshop"
alias ebash="nvim ~/workshop/lab/dotfiles/.bashrc && source ~/.bashrc"
alias ehc="nvim ~/workshop/lab/dotfiles/hypr/hyprland.conf"
alias enix="sudo nvim /etc/nixos/configuration.nix && rm -rf ~/workshop/lab/dotfiles/nixos/ && cp -r /etc/nixos/ ~/workshop/lab/dotfiles/"
alias nv="nvim"
alias vi="nvim"
alias gc="git commit -am"
alias gp="git push"
alias cat="bat"


function laz() {
   current_location = $(pwd)
   dot
   local message="$1"
   echo "Commit Message: $message"
   git add .
   git commit -m "$message"
   git push
   cd $current_location
}

function nixbuild() {
#set -e
pushd ~/workshop/lab/dotfiles
enix
local msg="$1"
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch &>nixos-switch.log || (
cat nixos-switch.log | grep --color error && false)
gen=$($msg || nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd
}
