{
  config,
  pkgs,
  system,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "thib";
  home.homeDirectory = "/home/thib";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Enabling dconf to customize GTK theme
  #programs.dconf.enable = true;

  programs.direnv.enable = true;

  # Enabling nnn because why not
  programs.nnn.enable = true;

  # programs.bash = {
  #  enable = true;
  #  initExtra = "
  #  if [ -f $HOME/workshop/lab/dotfiles/.bashrc ];
  #  then
  #  source $HOME/workshop/lab/dotfiles/.bashrc
  #  fi
  #";
  #};
  #
  programs.fish.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    #GUI tools
    nwg-look
    vlc
    wofi
    postman
    google-chrome
    mpv
    mission-center
    inputs.zen-browser.packages."${system}".default
    inputs.ollamark.packages."${system}".default
    inputs.antigravity-nix.packages.x86_64-linux.default
    mongodb-compass
    digikam
    darktable

    linux-firmware
    qimgv

    #CLI tools
    fastfetch
    pywal
    eza
    playerctl
    nmap
    openvpn
    gobuster
    hellwal

    #hyprland tools
    hyprlock
    hypridle
    waycorner
    quickshell
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/thib/etc/profile.d/hm-session-vars.sh
  #

  programs.neovim.enable = true;

  #programs.neovim = {
  #  enable = true;
  #  viAlias = true;
  #  vimAlias = true;
  #  vimdiffAlias = true;
  #
  #  extraPackages = with pkgs; [
  #    xclip
  #    wl-clipboard
  #  ];
  #
  #  plugins = with pkgs.vimPlugins; [
  #    nvim-lspconfig
  #    nvim-treesitter
  #    telescope-nvim
  #    telescope-fzf-native-nvim
  #    (nvim-treesitter.withPlugins (p: [
  #      p.tree-sitter-nix
  #      p.tree-sitter-vim
  #      p.tree-sitter-bash
  #      p.tree-sitter-json
  #    ]))
  #
  #    vim-nix
  #  ];
  #};

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
