# Hi, this is thibault's config

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./passthrough.nix
      ./hardware-configuration.nix
    ];

  # Here we go... FLAKES ENABLED !
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Trying to enable XDG Portal
  xdg.portal.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true; 
  
  programs.steam.enable = true;
  programs.kdeconnect.enable = true;
  programs.thunar.enable = true;
  programs.xfconf.enable = true;

  # Don't put spaces in the specialisation name, it prevents rebuilds
  specialisation."Windows_Mode".configuration = {
  system.nixos.tags = [ "with-vfio" ];
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
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
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
     (waybar.overrideAttrs (oldAttrs: {
	mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"];
})
)
     # terminal
     kitty
     starship
     alacritty
     
     # Linux tools
     waybar
     pfetch
     rofi
     hyprpaper
     pywal
     grim
     slurp
     cliphist
     wl-clipboard
     
     # Virtualization
     looking-glass-client
     xrdp
     
     # Browsing
     
     # Dev
     vscode
     go
     python3
     git
     bun
     
     # CLI tools
     vim
     btop
     htop
     neovim
     fzf
     bat
     killall
     wget
     
     # Games
     
     # Tools
     syncthing
     spotify
     obsidian
     signal-desktop
     keepassxc
     
     # Misc
     xrdp
     networkmanager
     swaylock
     plasma-pa
     pavucontrol
     vlc
     gnome3.adwaita-icon-theme
     glib
     pamixer
     freerdp
     lm_sensors
     obs-studio
     webcord
];

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


