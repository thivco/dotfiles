{ inputs, config, pkgs, lib, ... }:

{
  # kanata for home row
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          # Replace the paths below with the appropriate device paths for your setup.
          # Use `ls /dev/input/by-path/` to find your keyboard devices.
          "/dev/input/by-path/pci-0000:10:00.0-usbv2-0:3.1:1.0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
      (defsrc
        caps a o e u h t n s
      )
 (defvar
           tap-time 150
           hold-time 200
          )

        (defalias
           escctrl (tap-hold 100 100 esc lctl)
           a (tap-hold $tap-time $hold-time a lmet)
           o (tap-hold $tap-time $hold-time o lalt)
           e (tap-hold $tap-time $hold-time e lsft)
           u (tap-hold $tap-time $hold-time u lctl)
           h (tap-hold $tap-time $hold-time h rctl)
           t (tap-hold $tap-time $hold-time t rsft)
           n (tap-hold $tap-time $hold-time n ralt)
           s (tap-hold $tap-time $hold-time s rmet)
          )

    (deflayer base
    @escctrl @a @o @e @u @h @t @n @s
    )
        '';
      };

    };
  };
}
