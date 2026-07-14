let
  # 7900 XTX
  user = "thib";
  gpuIDs = [
    "1002:744c" # Graphics
    "1002:ab30" # Audio
  ];
in
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.vfio;
in
{

  options.vfio.enable = with lib; mkEnableOption "Configure the machine for VFIO";
  config = lib.mkIf cfg.enable {
    boot.initrd.kernelModules = [
      "vfio"
      "vfio_pci"
      "vfio_iommu_type1"

      "amdgpu"
      #adding it last so that vfio claims the GPU first
    ];

    #      initrd.kernelModulesBlacklist = lib.mkIf cfg.enable [ "amdgpu" ];

    boot.kernelParams =
      [
        "amd_iommu=on"
        "iommu=pt"
        "loglevel=3"
        #          "vfio-pci.ids=1002:744c,1002:ab30"
      ]
        # isolate the GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);

    boot.blacklistedKernelModules = [ "amdgpu" ];

    virtualisation.spiceUSBRedirection.enable = true;

    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 thib qemu-libvirtd -"
    ];

    environment.systemPackages = with pkgs; [
      virt-manager
      qemu
      pciutils
    ];

    virtualisation.libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";

      extraConfig = ''
        user="${user}"
      '';

      qemu = {
        swtpm.enable = true;
        verbatimConfig = ''
          namespaces = []
          user = "+${builtins.toString config.users.users.${user}.uid}"
        '';
        package = pkgs.qemu_kvm;
        runAsRoot = false;
      };

    };

    users.users.thib.extraGroups = [
      "libvirtd"
      "kvm"
      "disk"
    ];
    users.groups.libvirtd.members = [
      "thib"
      "root"
    ];
  };
}
