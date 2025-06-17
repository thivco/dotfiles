# Hi, this is thibault's config

{ config, lib, pkgs, zen-browser, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./passthrough.nix
    ];

# Here we go... FLAKES ENABLED !
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Enable ssh
  services.openssh.enable = true;

# This should enable binaries but I have no clues...
  programs.nix-ld.enable = true;
#programs.nix-ld.libraries = with pkgs; []

# Enable nginx
# Or disable it because of this dumb certificate issue which I will conveniently ignore
  services.nginx.enable = false;
#  services.nginx.virtualHosts."local.host" = {
#    addSSL = true;
#    enableACME = true;
#    root = "/var/www/local.host";
#  };
#
# Test installing font thank you mr llm

  security.acme = {
    acceptTerms = true;
    defaults.email = "foo@bar.com";
  };

#testing emulation
  virtualisation.waydroid.enable = true;
  virtualisation.lxd.enable = true;


# Trying to enable XDG Portal
  xdg.portal.enable = true;

# Enable Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true; 

# Detect ext drives
  services.udisks2.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];

  programs.steam.enable = true;
  programs.kdeconnect.enable = true;
  programs.thunar.enable = true;
  services.tumbler.enable = true;
# Enables tumbler to get image preview on when using thunar
  programs.xfconf.enable = true;

# Don't put spaces in the specialisation name, it prevents rebuilds
  specialisation.win_mode.configuration = {
    boot.kernelParams=["loglevel=2"];
    vfio.enable = true;
  };

# Enable memtest to test memory at boot
  boot.loader.systemd-boot.memtest86.enable = true;

# Allows Unfree packages
  nixpkgs.config.allowUnfree = true;

# Allows insecure packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

# Enable SDDM
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
#  services.xserver.videoDrivers = lib.mkIf (!config.vfio.enable) [ "amdgpu" ];
  services.xserver.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    wayland.enable = true;
    settings = {
      General = {
        DisplayServer = "wayland";
        MinimumVT = 1; # Force SDDM on tty1
      };
    };
  };

# Keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";
  };

  console.keyMap = "dvorak";

# Fonts
  fonts.packages = with pkgs; [
    fira-code
      iosevka
#    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" "ComicShannsMono" "Iosevka"]; })
  ];

# Installing Nautilus
  services.gvfs.enable = true;

# AMD drivers related

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

# Enable sound using Pipewire

# sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

# Enabling with Pulseaudio as well to check bluetooth integration
  services.pulseaudio.enable = false;

# Bluetooth configuration
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
	Name = "NixBluetooth";
	ControllerMode = "dual";
	FastConnectable = "true";
	Experimental = "true";
      };
      Policy = {
	AutoEnable = "true";
      };
    };
  };
  hardware.enableAllFirmware = true;

# Disable onboard BT
  boot.blacklistedKernelModules = [ "rtw89_8852ce" ];


#Enable the BT tui
  services.blueman.enable = true;

  services.udev.packages = with pkgs; [
    steam-unwrapped
  ];


  services.udev.extraRules = ''
    SUBSYSTEM=="input", GROUP="input", MODE="0660"
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
    '';

  environment.etc."bluetooth/main.conf".text = lib.mkForce ''
    [Policy]
    AutoEnable=true

    [General]
    Enable=Source,Sink,MediaControl,Socket,HID
	  FastConnectable=true
    Experimental=true
	'';

  environment.etc."bluetooth/input.conf".text = lib.mkForce ''
    [General]
    IdleTimeout=0
      '';

# Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;

# networking.hostName = "nixos"; # Define your hostname.
# Pick only one of the below networking options.
#networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

# Set your time zone.
    time.timeZone = "Europe/Amsterdam";

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


# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.thib = {
    isNormalUser = true;
    extraGroups = [ "wheel" "disk"]; # Enables ‘sudo’ for the user.
      openssh.authorizedKeys.keys = ["AAAAC3NzaC1lZDI1NTE5AAAAIDAcczjaWc2NHGIBFxArYGkivl4lzC27N5IXlXoiZD0N"];
    packages = with pkgs; [
      firefox
	tree
    ];
  };

# List packages installed in system profile. To search, run:
# $ nix search wget



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


