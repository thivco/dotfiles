{
  config,
  pkgs,
  lib,
  ...
}:

{
  hardware.graphics = {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  boot.kernelParams = [
    "amdgpu.vm_fragment_size=9"
  ];

  services.ollama = {
    enable = true;
    # after = [ "graphical-session.target" ];
    # wantedBy = lib.mkForce [ "multi-user.target" ];
  };

  systemd.services.ollama.serviceConfig = {
    PrivateNetwork = true;
    RestrictAddressFamilies = [ "AF_UNIX" ];
  };

  environment.variables.OLLAMA_ACCELERATOR = "rocm";
}
