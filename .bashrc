#
# ~/.bashrc
#
#wal -i $DOTFILES_LOC/wallpaper/polaris_fatalism.jpg -q
#(wal -r &)
(cat /home/thib/.cache/wal/sequences)
#(bash /home/thib/workshop/lab/dotfiles/.config/set_wallpaper.sh &)

if [[ $(tty) == "/dev/tty1" ]]; then
  exec Hyprland
fi

eval "$(starship init bash)"
#eval "$(thefuck --alias)"
#eval "$(thefuck --alias fk)"
source "$(fzf-share)/key-bindings.bash"
source "$(fzf-share)/completion.bash"
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#clear

# Env variables ?
NVIM_APPNAME=nvim
DOTFILES_LOC="$HOME/workshop/lab/dotfiles/"
EDITOR=nvim
QT_QPA_PLATFORMTHEME=qt6ct
QT_QPA_PLATFORM=wayland
# Create a dedicated virt bash script to run at boot

# Aliases to access various directories
alias dot="cd $DOTFILES_LOC"
alias lab="cd ~/workshop/lab"
alias cidem="cd ~/workshop/lab/cidem/&& nix-shell"
alias ws="cd ~/workshop"
alias ddev="docker compose down --remove-orphans && docker compose -f docker-compose.dev.yml up -d"

alias notivi="notify-send 'hi' !"
# Aliases to edit config files

alias ebash="$NVIM_APPNAME $DOTFILES_LOC/.bashrc && source $DOTFILES_LOC/.bashrc"
alias ehc="$NVIM_APPNAME $DOTFILES_LOC/hypr/hyprland.conf"
alias enix="pushd $DOTFILES_LOC/nix/ && $NVIM_APPNAME"
alias eflake="$NVIM_APPNAME $DOTFILES_LOC/nix/flake.nix"
alias ehm="$NVIM_APPNAME $DOTFILES_LOC/nix/home.nix" 
alias flake="sudo nixos-rebuild switch --flake $DOTFILES_LOC/nix"
alias sass="npx sass --watch *.scss style.css"
alias nvim_config="cp -r ~/.config/nvim/ $DOTFILES_LOC/.config/"
#alias envim="pushd ~/workshop/lab/dotfiles/.config/nvim/ && $NVIM_APPNAME && popd" 
alias envim="pushd ~/workshop/lab/dotfiles/.config/nvim/ && $NVIM_APPNAME && rm -rf ~/.config/nvim/ && cp -r ~/workshop/lab/dotfiles/.config/nvim/ ~/.config/nvim/ && popd" 
alias aptu="nix-channel --update && sudo flake"
alias tsession="bash ~/workshop/lab/dotfiles/.config/scripts/tmux_session_distribution.sh"
alias dore="docker compose down && docker compose -f docker-compose.dev.yml up -d --build"


# vim alias
alias nv="nvim"
alias vi="nvim"
alias vim="nvim"

# git
alias ga="git add"
alias gc="git commit" 
alias gs="git status --short"
alias gp="git push"
alias gu="git pull"
alias gco="git checkout"
alias gcl="git clone"
alias gl="git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'"
#cli tools
alias cat="bat --theme=TwoDark"
alias icat="kitten icat"
#alias ls='eza -lAh --color=auto':
alias grep='grep --color=auto'

#desktop effects
alias waybaru="waybar -c $DOTFILES_LOC/.config/waybar/config -s $DOTFILES_LOC/.config/waybar/style.css"

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
	pushd $DOTFILES_LOC
	enix
	local msg="$1"
	git diff -U0 *.nix
	echo "NixOS Rebuilding..."
	sudo nixos-rebuild switch --flake /etc/nixos/flake.nix &>nixos-switch.log || (
	cat nixos-switch.log | grep --color error && false)
	#gen=$($msg || nixos-rebuild list-generations | grep current)
	#[[ $msg != "" ]] && $gen="$msg" || $gen=nixos-rebuild list-generation | grep current
	git commit -am "$msg"
	popd
}

function git_feature_branch(){
  local feature_name="$1"
  local commit_message="$2"
  echo git checkout -b "feature-${feature_name}" && git add . && git commit -m "new branch : ${feature_name}, ${commit_message}" && git push -u origin "feature-${feature_name}"
}

git_push(){
  local commit_message="$1"
  git add . && git commit -m "${commit_message}" && git push
}

function open_video_with_mpv_ultrawide(){
  local video="$1"
  
  local command_line="mpv ${video}" 
  if [ $2 = "w" ]; then
   command_line="${command_line} --vf=crop=in_w:in_w/2.39" 
  fi
  ${command_line}
}

function tmux_session_check() 
{
  echo "Checking if session exists..."
selected_name=$1
selected_path=$2
  if ! tmux has-session -t "$selected_name"; then
  tmux new-session -ds "$selected_name" -c "$selected_path"
  echo "session exists"
  tmux select-window -t "$selected_name:1"
fi


if [ -e "$selected_path/shell.nix" ]; then
  echo "nix shell exists, enterring..."
  nix-shell "$selected_path/shell.nix"
else
  echo "no nix shell"
  echo "Entering the session."
  tmux attach -t "$selected_name"
fi
}

alias uwide='open_video_with_mpv_ultrawide'
alias wayboar=waybar

alias unhype="pkill -USR1 hyprlock"

# [[ -f ~/.bashrc ]] && . ~/.bashrc
