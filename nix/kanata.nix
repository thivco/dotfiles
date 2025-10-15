{ inputs, config, pkgs, lib, ... }:

{
  # Enable and configure Kanata declaratively
  programs.kanata = {
    enable = true;
    config = ''
      (defsrc
        a o e u i d h t n s
      )

      (deflayer base
        (tap-hold 200 a lctrl)
        (tap-hold 200 o lalt)
        (tap-hold 200 e lshift)
        (tap-hold 200 u lmeta)
        i
        (tap-hold 200 d rctrl)
        (tap-hold 200 h ralt)
        (tap-hold 200 t rshift)
        (tap-hold 200 n rmeta)
        s
      )
    '';
  };
}

