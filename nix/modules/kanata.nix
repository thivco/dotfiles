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
            asdf jklm
          )
          (defvar
             tap-time 150
             hold-time 200
           )

          (defalias
             escctrl (tap-hold 100 100 caps lctl)
             a (tap-hold $tap-time $hold-time a lmet)
             s (tap-hold $tap-time $hold-time s lsft)
             d (tap-hold $tap-time $hold-time d ralt)
             f (tap-hold $tap-time $hold-time f rsft)
             j (tap-hold $tap-time $hold-time j rctl)
             k (tap-hold $tap-time $hold-time k lmet)
             l (tap-hold $tap-time $hold-time l lsft)
             m (tap-hold $tap-time $hold-time m ralt)
           )

          (deflayer base
            @escctrl @a @s @d @f @j @k @l @m
          )
        '';
      };

    };
  };
}
