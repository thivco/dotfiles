{
  description = "First flake";

  inputs = {
# NixOS official package source, using the nixos unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/hyprland?ref=v0.36.0";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      modules = [
# Import the previous configuration.nix we used,
# so the old configuration file still takes effect
	  ./configuration.nix
      ];
    };
    homeConfigurations = {
      thib = home-manager.lib.homeManagerConfiguration  {
	inherit pkgs;
	modules = [./home.nix];
      };
    };
  };
}
