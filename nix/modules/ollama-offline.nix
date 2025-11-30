{
  description = "Ollama + Ollamark module";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # bring the tool in
    ollamark.url = "github:knoopx/ollamark";
  };

  outputs =
    {
      self,
      nixpkgs,
      ollamark,
      ...
    }:
    {
      nixosModules.ollamaModule =
        { config, pkgs, ... }:
        {
          hardware.graphics = {
            enable = true;
            extraPackages = with pkgs; [
              rocmPackages.clr.icd
            ];
          };

          boot.kernelParams = [
            "amdgpu.vm_fragment_size=9"
          ];

          services.ollama.enable = true;

          nixpkgs.overlays = [
            ollamark.overlays.default
          ];

          environment.systemPackages = [
            pkgs.ollamark
          ];

          systemd.services.ollama.serviceConfig = {
            PrivateNetwork = true;
            RestrictAddressFamilies = [ "AF_UNIX" ];
          };

          environment.variables.OLLAMA_ACCELERATOR = "rocm";
        };
    };
}
