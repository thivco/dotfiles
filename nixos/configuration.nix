# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# This is  a comment so that it regenerates a new config AND STOPS CRASHING

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
#      ./passthrough.nix
      ./hardware-configuration.nix
    ];

  # Trying to enable XDG Portal
  # Note for future-self, PLEASE WRITE DOWN THE REASON YOU'VE INSTALLED THIS :) (:
  xdg.portal.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;
  
  # Enable Steam
#  programs.steam {
#    enable = true;
#    remotePlay.openFirewall = true;
#    dedicatedServer.openFirewall = true;
#  };
  programs.steam.enable = true;

  # Virtualization (one day...)
  #boot.kernelParams = [ "amd_iommu=on" ];
  #boot.blacklistedKernelModules = ["amdgpu" "radeon"];
  #boot.kernelModules = [ "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio"];
  #boot.extraModprobeConfig = "options vfio-pci ids=1002:744c,1002:ab30";
  
  # Allows Unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allows insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
           
  # Enable SDDM
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  # Keyboard
  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "ComicShannsMono" "Iosevka"]; })
  ];

  # Installing Nautilus
  services.gvfs.enable = true;

  # Enable sound using Pipewire

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enabling with Pulseaudio as well to check bluetooth integration
  hardware.pulseaudio.enable = true;

  # Bluetooth configuration
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.thib = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enables ‘sudo’ for the user.
     packages = with pkgs; [
       firefox
       tree
     ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     alacritty
     keepassxc
     kitty
     waybar
     (waybar.overrideAttrs (oldAttrs: {
	mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"];
})
)
     syncthing
     starship
     git
     neovim
     pfetch
     rofi
     killall
     swaylock
     dolphin
     spotify
     bun
     grim
     plasma-pa
     hyprpaper
     pavucontrol
     pywal
     go
     obsidian
     fzf
     # mako
     cliphist
     wl-clipboard
     python3
     vlc
     vscode
     steamcmd
   ];

#	  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
#    "steam"
#    "steam-original"
#   "steam-run"
#    "spotify"
#  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

