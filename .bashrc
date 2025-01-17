#
# ~/.bashrc
#
#wal -i ~/workshop/lab/dotfiles/wallpaper/polaris_fatalism.jpg -q
(wal -r &)
#(bash /home/thib/workshop/lab/dotfiles/.config/set_wallpaper.sh &)

if [[ $(tty) == "/dev/tty1" ]]; then
  exec Hyprland
fi

eval "$(starship init bash)"
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"
source "$(fzf-share)/key-bindings.bash"
source "$(fzf-share)/completion.bash"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Env variables ?
DOTFILES_LOC=~/workshop/lab/dotfiles

# Create a dedicated virt bash script to run at boot

# Aliases to access various directories
alias dot="cd ~/workshop/lab/dotfiles"
alias lab="cd ~/workshop/lab"
alias ws="cd ~/workshop"

# Aliases to edit config files
alias ebash="nvim ~/workshop/lab/dotfiles/.bashrc && source ~/workshop/lab/dotfiles/.bashrc"
alias ehc="nvim ~/workshop/lab/dotfiles/hypr/hyprland.conf"
alias enix="nvim ~/workshop/lab/dotfiles/nix/configuration.nix"
alias hm="nvim $DOTFILES_LOC/nix/home.nix && home-manager switch --flake $DOTFILES_LOC/nix"
alias flake="sudo nixos-rebuild switch --flake $DOTFILES_LOC/nix"
alias sass="npx sass --watch *.scss style.css"
alias nvim_config="rm -rf ~/workshop/lab/dotfiles/.config/nvim/ && cp -r ~/.config/nvim/ ~/workshop/lab/dotfiles/.config/nvim/"
alias envim="pushd ~/.config/nvim && nvim . && popd" 
alias aptu="nix-channel --update && sudo flake"

# QOL alias
alias nv="nvim"
alias vi="nvim"
alias gc="git commit -am"
alias gp="git push"
alias cat="bat"
alias icat="kitten icat"
alias ls="eza -lAh"
alias l='ls -lah --color=auto'
alias grep='grep --color=auto'
alias fk='thefuck --alias'

function laz() {
	current_location=$(pwd)
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
	#gen=$($msg || nixos-rebuild list-generations | grep current)
	#[[ $msg != "" ]] && $gen="$msg" || $gen=nixos-rebuild list-generation | grep current
	git commit -am "$msg"
	popd
}

alias wayboar=waybar

clear
