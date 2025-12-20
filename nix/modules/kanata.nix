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
            caps a s d f j k l ;
          )

          (defvar
             tap-time 150
             hold-time 200
           )

          (defalias
             caps (tap-hold 100 100 esc lctl)
             a (tap-hold $tap-time $hold-time a lctl)
             s (tap-hold $tap-time $hold-time s lsft)
             d (tap-hold $tap-time $hold-time d lmet)
             f (tap-hold $tap-time $hold-time f lalt)
             j (tap-hold $tap-time $hold-time j ralt)
             k (tap-hold $tap-time $hold-time k rmet)
             l (tap-hold $tap-time $hold-time l lsft)
             ; (tap-hold $tap-time $hold-time ; rctl)
           )

          (deflayer base
            @caps @a @s @d @f @j @k @l @;
          )
        '';
      };

    };
  };
}
