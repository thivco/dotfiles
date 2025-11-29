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

  programs.ollama.enable = true;

  systemd.services.ollama.serviceConfig = {
    PrivateNetwork = true;
    RestrictAddressFamilies = [ "AF_UNIX" ];
  };

  environment.variables.OLLAMA_ACCELERATOR = "rocm";
}
