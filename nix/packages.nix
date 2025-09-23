{ zen-browser, config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs;

  [

# terminal
      kitty
      starship
      burpsuite
      alacritty

# Linux tools
      waybar
      pfetch
      rofi
      hyprpaper
      pywal
      grim
      grimblast
      slurp
      cliphist
      wl-clipboard
      hyprcursor
      dunst
      swww
      libnotify
      lact
      xmlstarlet

# Virtualization
      looking-glass-client
      xrdp

# Browsing
      chromium

# Dev
      vscode
      windsurf
#go
      python3
      git
      bun

# CLI tools
      vim
      btop
      htop
      ripgrep
      tldr
      ffmpeg
      usbutils

#neovim
      fzf
      bat
      killall
      wget
      ntfs3g
      devenv
      gcc
      simple-mtpfs
      zip

# Games
      wine
      lutris

# Tools
      syncthing
      spotify
      obsidian
      nginx
      signal-desktop
      keepassxc
      steamcmd
      calibre

# Web tools
      deno
      #atlas #MongoDB tool
      #mongosh
      nodejs

# Misc
      xrdp
#      zen-browser.packages."$(system)".default
      xwayland
      networkmanager
      swaylock
      kdePackages.plasma-pa
      pavucontrol
      scrcpy
      glib
      pamixer
      freerdp
      lm_sensors
      obs-studio
      #thefuck
      webcord
      mako
# idk how to install this one yet      tokyo-night-sddm
      swtpm

#usb/mount
      udiskie
      udisks2

#Fonts
      jetbrains-mono
      font-awesome

# Language server protocol
      nodePackages.typescript
      nodePackages.typescript-language-server
      lua-language-server
      bash-language-server
      vue-language-server
      dockerfile-language-server-nodejs
      superhtml
      vscode-langservers-extracted
#      javascript-typescript-langserver 
      ];
}


