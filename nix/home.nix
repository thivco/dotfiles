{ config, pkgs, ... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
home.username = "thib";
home.homeDirectory = "/home/thib";


home.stateVersion = "24.05"; # Please read the comment before changing.

programs.direnv.enable = true;

# Enabling nnn because why not
programs.nnn.enable = true;

programs.bash = {
  enable = true;
  initExtra = "
  if [ -f $HOME/workshop/lab/dotfiles/.bashrc ];
  then
  source $HOME/workshop/lab/dotfiles/.bashrc
  fi
";
};

nixpkgs.config.allowUnfree = true;
# The home.packages option allows you to install Nix packages into your
# environment.

home.packages = [
  pkgs.wofi
  pkgs.postman
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

programs.neovim = {
  enable = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;

  plugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    telescope-nvim
    telescope-fzf-native-nvim
    (nvim-treesitter.withPlugins (p: [
      p.tree-sitter-nix
      p.tree-sitter-vim
      p.tree-sitter-bash
      p.tree-sitter-json
    ]))

    vim-nix
  ];
};

home.sessionVariables = {
};

# Let Home Manager install and manage itself.
programs.home-manager.enable = true;
}
