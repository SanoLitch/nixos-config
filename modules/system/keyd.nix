{ pkgs, lib, ... }:
let
  commonSettings = {
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
        ids = [ "046d:b362:7870a075" ];
        settings = lib.mkMerge [
          {
            main = {
              capslock = "overload(control, esc)";
              leftmeta = "layer(meta_mac)";
              leftalt = "leftmeta";
              leftcontrol = "leftalt";
            };
          }
          commonSettings
        ];
      };
      dell = {
        ids = [ "0001:0001:6fb3735a" ];
        settings = lib.mkMerge [
          {
            main = {
              capslock = "overload(control, esc)";
              leftalt = "layer(meta_mac)";
              leftcontrol = "leftalt";
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
