let
# 7900 XTX
user = "thib";
gpuIDs = [
  "1002:744c" # Graphics
  "1002:ab30" # Audio
];
in { pkgs, lib, config, ... }: {
  
  options.vfio.enable = with lib;
    mkEnableOption "Configure the machine for VFIO";
  config = let cfg = config.vfio;
  in {
    boot.initrd.kernelModules = [ 
        "vfio"
          "vfio_pci"
          "vfio_iommu_type1"
          
          "amdgpu"
          #adding it last so that vfio claims the GPU first
      ];

#      initrd.kernelModulesBlacklist = lib.mkIf cfg.enable [ "amdgpu" ];

      boot.kernelParams = [
        "amd_iommu=on"
          "iommu=pt"
          "loglevel=3"
#          "vfio-pci.ids=1002:744c,1002:ab30"
             ] ++ lib.optional cfg.enable
        # isolate the GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
      boot.blacklistedKernelModules = [ "amdgpu" ];


    hardware.graphics.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

# Creates the shared memory file

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
        ovmf.enable = true ;
        swtpm.enable = true;
        verbatimConfig = ''
          namespaces = []
          user = "+${builtins.toString config.users.users.${user}.uid}"
          '';
        package = pkgs.qemu_kvm;
        runAsRoot = false;
      };


    };

    users.users.thib.extraGroups = [ "libvirtd" "kvm" ];
    users.groups.libvirtd.members = [ "thib" "root" ];
};
}
