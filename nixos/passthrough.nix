let
  # 7900 XTX
  gpuIDs = [
    "1002:744c" # Graphics
    "1002:ab30" # Audio
  ];
in { pkgs, lib, config, ... }: {
  options.vfio.enable = with lib;
    mkEnableOption "Configure the machine for VFIO";

  config = let cfg = config.vfio;
  in {
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        "vfio_virqfd"
	
	"amdgpu"
      ];

      kernelParams = [
        # enable IOMMU
        "amd_iommu=on" "iommu=pt"
      ] ++ lib.optional cfg.enable
        # isolate the GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
    };

    hardware.opengl.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  
      environment.systemPackages = with pkgs; [
      virt-manager
      qemu
      pciutils
    ];

    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.qemuPackage = pkgs.qemu_kvm;

    users.groups.libvirtd.members = [ "thib" "root" ];


  };
}
