{ pkgs, lib, ... }:
let
  commonSettings = {
    main = {
      capslock = "overload(control, esc)";
      space = "overload(nav, space)";
      leftcontrol = "leftalt";
    };
    "meta_mac:C" = {
      c = "C-insert";
      v = "S-insert";
      x = "S-delete";
      a = "C-a";
      f = "C-f";
      r = "C-r";
      z = "C-z";
      t = "C-t";
      tab = "C-tab";
      minus = "C-minus";
      equal = "C-equal";
      left = "home";
      right = "end";
      backspace = "C-backspace";
      delete = "C-delete";
    };
    nav = {
      h = "left";
      j = "down";
      k = "up";
      l = "right";
      d = "backspace";
      x = "delete";
    };
    control = {
      space = "M-space";
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    keyd
  ];

  services.keyd = {
    enable = true;
    keyboards = {
      K380 = {
        ids = [ "046d:b362" ];
        settings = lib.mkMerge [
          {
            main = {
              leftmeta = "layer(meta_mac)";
              leftalt = "leftmeta";
            };
          }
          commonSettings
        ];
      };
      dell = {
        ids = [ "0001:0001" ];
        settings = lib.mkMerge [
          {
            main = {
              leftalt = "layer(meta_mac)";
            };
          }
          commonSettings
        ];
      };
    };
  };

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
}
