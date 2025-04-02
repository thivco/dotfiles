let
# 7900 XTX
user = "thib";
gpuIDs = [
  "1002:744c" # Graphics
  "1002:ab30" # Audio
];
in { pkgs, lib, config, ... }: {
  options.vfio.enable = with lib; 
  mkEnableOption "TEST __ GPU Detachable";

  config = let cfg = config.vfio;
  in {
    boot = {
      initrd.kernelModules = [
	"vfio"
	  "vfio_pci"
	  "vfio_iommu_type1"
	  "amdgpu"
      ];

      kernelParams = [
# enable IOMMU
	"amd_iommu=on"
	  "iommu=pt"
	  "loglevel=3"
      ] ++ lib.optional cfg.enable
# isolate the GPU
      ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
    };

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

      qemuOvmf = true;
      qemuSwtpm = true;

      extraConfig = ''
	user="${user}"
	'';

      qemu = {
	ovmf.enable = true ;
	verbatimConfig = ''
	  namespaces = []
	  user = "+${builtins.toString config.users.users.${user}.uid}"
	  '';
	package = pkgs.qemu_kvm;
	runAsRoot = false;
      };


};

users.groups.libvirtd.members = [ "thib" "root" ];

};
}
